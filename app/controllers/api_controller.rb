class ApiController < ApplicationController
  @@max_news = 30000
  #@@host = "localhost"
  #@@port = 3000
  @@host = "heygotimes.heroku.com"
  @@port = 80

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

      # @url = 'http://www.facebook.com/sharer.php?u=' + params[:url]
      # @url = 'http://developers.facebook.com/tools/lint/?url=' + URI.encode(params[:url])
      url = 'http://developers.facebook.com/tools/lint/?url=' + URI.encode(params[:url])
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

      doc.search('h2 > div.pam', 'td').each do |data|
        # puts data.content

        if (data.content == 'Description')
          next_element = :content
          next
        elsif (data.content == 'Title')
          next_element = :title
          next
        elsif (data.content == 'Image')
          next_element = :image
          next
        end

        if (next_element == :content)
          text = data.content
        elsif (next_element == :image)
          image_url = data.search('a').first['href']
        elsif (next_element == :title)
          title = data.content
          break
        end

        next_element = :normal
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
      @news = News.new(params[:news])
      @news.url = params[:url]
      @news.title = title

      @news.save
    end


    response_str = "OK!"  #title=" + @data[:title] + "  text=" + @data[:text] + "  image url="+  @data[:image]

    req = Net::HTTP::Post.new("/api/add_news", initheader = {'Content-Type' =>'application/json'})
    req.body = @payload.to_json
    response = Net::HTTP.new(@@host, @@port).start {|http| http.request(req) }

    respond_to do |format|
      format.html { render  :inline => response_str }
    end

  end

  def add_news
    response_data = {}
    # Check URL existence
    @news = News.find_by_url(params[:url])
    if (@news != nil)
      response_data['status'] = 'duplicate!!'
      respond_to do |format|
        format.json { render :json => response_data.to_json }
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
      @image = Image.create(params[:image])
      @image.news = @news
      @image.url = params[:image]
      @image.save
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
  end

  response_data['status'] = 'ok!'
  respond_to do |format|
    format.json { render :json => response_data.to_json }
  end
end
