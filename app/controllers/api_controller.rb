# encoding: utf-8

class ApiController < ApplicationController
  @@max_news = 30000

  if ENV['RAILS_ENV'] != 'development'
    @@host = "www.heygotimes.com"
    @@port = 80
  else
    @@host = "localhost"
    @@port = 3000
  end

  def new_news
    # parameter: # area, tags,  url

    # this method is referenced from news_controller/report
    #
    require 'open-uri'
    require 'nokogiri'
    require 'net/http'
    require 'json'

    response_str = ""

    @payload = {
      "url" => params[:url],
      "publish" => params[:publish],
      "area" => params[:area],
      "tags" => params[:tags]
    }
    @payload["focus_flag"] = params[:focus_flag] if params[:focus_flag] != nil
    @payload["no_photo"] = params[:no_photo] if params[:no_photo] != nil

    #@data = Hash.new
    if (params[:url] != nil)

      # Check URL existence
      @news = News.find_by_url(params[:url])
      if (@news != nil)
          response_str = 'duplicate!!'
          respond_to do |format|
            format.html { render  :inline => response_str }
          end

          return
      end


      # Parse data

      # url = 'http://www.facebook.com/sharer.php?u=' + params[:url]
      # url = 'http://developers.facebook.com/tools/lint/?url=' + URI.encode(params[:url])
      url = 'https://developers.facebook.com/tools/debug/og/object?q=' + params[:url]

      next_element = ''
      title = ''
      image_url = ''
      text = ''

      begin
        stream = open(url)
      rescue
        # try again
        stream = open(url)
      end

      doc = Nokogiri::HTML(stream, nil, 'utf-8')

      fetched = true
        doc.search('td', 'b').each do |data|
          # puts data.content

          if (data.content == 'Data Source')
            fetched = false
            next
          end

          if fetched == false
            if data.content.include? 'og:title'
              start_pos = data.content.index('content')
              title = data.content[start_pos+9..-4]
              fetched = true
            elsif data.content.include? 'og:description'
              start_pos = data.content.index('content')
              text = data.content[start_pos+9..-4]
              fetched = true
            elsif data.content.include? 'og:image'
              start_pos = data.content.index('http')
              image_url = data.content[start_pos..-1]
              fetched = true
            elsif data.content.include? 'title'
              end_pos = data.content.index('extracted')
              if end_pos == nil
                title = data.content[1..-1]
              else
                title = data.content[1..end_pos-2]
              end

              fetched = true
            elsif data.content.include? 'description'
              end_pos = data.content.index('..')
              if end_pos == nil
                end_pos = data.content.index('extracted')
                if end_pos == nil
                  end_pos = 0
                end
                text = data.content[1..end_pos-1]
              else
                text = data.content[1..end_pos+1]
              end

              fetched = true
            end
          end

        end

      @payload['title'] = title
      @payload['image'] = image_url
      @payload['text'] = text

      if(title != nil && title != "")
        news_temp = News.find_by_title(title)
        if (news_temp != nil)
          response_str = 'title-duplicate!!'
          respond_to do |format|
            format.html { render  :inline => response_str }
          end

          return
        end
      else
        response_str = 'no title!!'
        respond_to do |format|
          format.html { render  :inline => response_str }
        end

        return

      end

      #
      # create a new news record and save to db  (reference to news_contrller/create
      #
      if ENV['RAILS_ENV'] != 'development'
        @news = News.new(params[:news])
        @news.url = params[:url]
        @news.title = title

        @news.save
      end

      if (News.count > @@max_news)
          outdated_news = News.where(:news=>{:special_flag => false}).order('news.created_at').first
          News.destroy(outdated_news.id)
          puts 'removed news: '+outdated_news.id.to_s
      end
    end


    response_str = "OK!"  #title=" + @data[:title] + "  text=" + @data[:text] + "  image url="+  @data[:image]

    req = Net::HTTP::Post.new("/api/add_news", initheader = {'Content-Type' =>'application/json'})
    req.body = @payload.to_json
    response = Net::HTTP.new(@@host, @@port).start {|http| http.request(req) }

    respond_to do |format|
      format.html { render :inline => response_str }
    end

  end




  def add_news

    if (params[:title]).include?("http://")
      return
    end

    # Check URL existence
    @news = News.find_by_url(params[:url])
    if (@news != nil)
        respond_to do |format|
          format.json { render :json => @news }
        end

        return
    end

    @news = News.new(params[:news])
    @user = User.find(2)   #reporter
    @news.user = @user

    @news.title = params[:title]
    @news.content = params[:text]
    @news.url = params[:url]

    if(params[:publish] == "yes")
      @news.special_flag= false
    else
      @news.special_flag= true
    end

      if params[:no_photo] == nil ||  params[:no_photo] != 'yes'
          
          if  params[:image] != nil &&  params[:image] != ' '
              @image = Image.create(params[:image])
              @image.news = @news
              @image.url = params[:image]
              @image.save
          end
          
      end

    @news.tags = []
    tags = Tag.all
    tags.each do |tag|
      if params[:tags].include?(tag.name)
        @news.tags << tag  # many-to-many relationship ==> it would be saved to DB automatically
      end
    end

    # setup areas of this news
    areas = Area.all
    @news.areas = []
    @news.area_string = params[:area]
    areas.each do |area|
      if params[:area].include?(area.name)
        @news.areas << area  # many-to-many relationship ==> it would be saved to DB automatically
      end
    end

    if(params[:focus_flag] == 'yes')
      @news.rank = 3
    end

    @news.save

    if (News.count > @@max_news)
      outdated_news = News.where(:news=>{:special_flag => false,:daily_news => false}).order('news.created_at').first
      News.destroy(outdated_news.id)
      puts 'removed news: '+outdated_news.id.to_s
    end

    respond_to do |format|
      format.json { render :json => @news }
    end
  end


    def news_rank_reduction
      sysdata = get_system_data
      if Time.now - sysdata.last_news_rank_reduction > 43200

        # hot_news = News.all.order('rank DESC').take(10)
        hot_news = News.get_all('rank', :none, nil, nil).take(100)

        curr_time = Time.now
        hot_news.each do |news|
          if (curr_time - news.created_at > 43200)
            if news.rank > 15
              news.rank -= 15
            else
              news.rank = 0
            end

            news.save
          end
        end

        sysdata.last_news_rank_reduction = curr_time
        sysdata.save
      end
    end

end
