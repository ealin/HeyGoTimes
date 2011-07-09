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

        doc = Nokogiri::HTML(stream)

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
            text = data.content.to_s
          elsif (next_element == :image)
            image_url = data.search('a').first['href']
          elsif (next_element == :title)
            title = data.content.to_s
            break
          end

          next_element = :normal
        end

        @data[:title]=title.to_s
        @data[:image]=image_url.to_s
        @data[:text]=text.to_s

          #
          # create a new news record and save to db  (reference to news_contrller/create
          #
          @news = News.new(params[:news])
          @user = User.find(2)   #reporter
          @news.user = @user

          @news.title = @data[:title]
          @news.content = @data[:text]
          @news.url = params[:url]
          @news.special_flag= true

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
          areas.each do |area|
            if params[:area].include?(area.name)
              @news.areas << area  # many-to-many relationship ==> it would be saved to DB automatically
            end
          end

          @news.save
    end


    response_str = "OK!"  #title=" + @data[:title] + "  text=" + @data[:text] + "  image url="+  @data[:image]

    respond_to do |format|
      format.html { render  :inline => response_str }
    end

  end

end
