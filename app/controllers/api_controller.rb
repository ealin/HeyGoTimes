class ApiController < ApplicationController
  def new_news
    # parameter: # area, tags,  url

    # this method is referenced from news_controller/report
    #
    require 'open-uri'
    require 'nokogiri'

    response_str = ""

    @data = {}
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

        @data[:title]=title
        @data[:image]=image_url
        @data[:text]=text

          #
          # create a new news record and save to db  (reference to news_contrller/create
          #
          @news = News.new(params[:news])
          @user = User.find(2)   #reporter
          @news.user = @user

          @news.title = @data[:title]
          @news.content = @data[:text]
          @news.url = params[:url]

          if(params[:publish] == "yes")
            @news.special_flag= false
          else
            @news.special_flag= true
          end

          @image = Image.create(@data[:image])
          @image.news = @news
          @image.url = @data[:image]
          @image.save

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
                # Ealin: 我給 news_rank_action 多了一個type - : focus, 但在這裡應該CALL不到news_rank_action
           end

          @news.save
    end


    response_str = "OK!"  #title=" + @data[:title] + "  text=" + @data[:text] + "  image url="+  @data[:image]

    respond_to do |format|
      format.html { render  :inline => response_str }
    end

  end

end
