class NewsController < ApplicationController
  # Use tiny_mce editor
  #uses_tiny_mce

  # GET /news
  # GET /news.xml
  def index
    # @news = News.paginate(:page => 1, :per_page => 3)
    @news = News.all.paginate(:page => params[:page], :per_page => 3)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @news }
    end
  end

  # GET /news/1
  # GET /news/1.xml
  def show
    @news = News.find(params[:id])
    @tags = Tag.all
    @areas = Area.all

    # check login status,
    # prevent direct link to news page => cause exception: current_facebook_user is nil
    check_logged_in(false)

    if (current_facebook_user != nil)
      @user = User.find(session[:id])
      @news.watches.push(@user)
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @news }
    end
  end

  def like

    @data = {}
    # check session id of user
    if (params[:user] == session[:id].to_s)
      @user = User.find(session[:id])
      @news = News.find(params[:news])

      # check if like/unlike of user already exists
      if (params[:like] == 1.to_s)
        if (@news.unlikes.include?(@user))
          @news.unlikes.delete(@user)
        end
        @news.likes.push(@user)
        @data['total'] = @news.likes.count
      else
        if (@news.likes.include?(@user))
          @news.likes.delete(@user)
        end
        @news.unlikes.push(@user)
        @data['total'] = @news.unlikes.count
      end

      # calculate rank
      @like_count = @news.likes.count
      @unlike_count = @news.unlikes.count
      @news.rank = @like_count - @unlike_count

      @data['name'] = @user.first_name + ' ' + @user.last_name

      @news.save
    end

    respond_to do |format|
      format.json { render :json => @data.to_json }
    end
  end

  # GET /report/new
  # GET /report/new.xml
  def report
    @data = {}

    if (params[:url] != nil)

      # Check URL existence
      if (params[:url] != nil)
        @news = News.find_by_url(params[:url].to_s)
        if (@news != nil)
          @data['ret'] = 'url exist'
        end
      end

      # Parse data
      if (@data['ret'] != 'url exist')
        require 'nokogiri'
        require 'open-uri'

        # @url = 'http://www.facebook.com/sharer.php?u=' + params[:url]
        @url = 'http://developers.facebook.com/tools/lint/?url=' + URI.encode(params[:url])
        @next = ''
        @doc = Nokogiri::HTML(open(@url))

        #@error = @doc.search('lint > lint_error')
        #if (@error != nil)
        #  @data['ret'] = 'bad url'
        #end

        # @body = @doc.at_css('body').text
        @doc.search('h2 > div.pam', 'td').each do |data|
          # puts data.content

          if (data.content == 'Description')
            @next = :content
            next
          elsif (data.content == 'Title')
            @next = :title
            next
          elsif (data.content == 'Image')
            @next = :image
            next
          end

          if (@next == :content)
            @text = data.content.to_s
          elsif (@next == :image)
            @image_url = data.search('a').first['href']
          elsif (@next == :title)
            @title = data.content.to_s
            break
          end

          @next = :normal
        end

        @data['title']=@title.to_s
        @data['image']=@image_url.to_s
        @data['text']=@text.to_s
      end
    end

    respond_to do |format|
      format.json { render :json => @data.to_json }
    end

  end

  # GET /news/new
  # GET /news/new.xml
  def new
    @news = News.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @news }
    end
  end

  # GET /news/1/edit
  def edit
    @news = News.find(params[:id])
  end

  # POST /news
  # POST /news.xml
  def create
    @news = News.new(params[:news])
    @user = User.find(session[:id])
    @news.user = @user

    @image = Image.create(:url => params[:image_url])
    @image.news = @news
    @image.save

    @news.tags = ""
    counter = 0
    params.each_pair do |key, value|
      if (value == 'on')
        tag = Tag.find_by_name(key)
        @news.tags << tag
        counter += 1
      end
    end

    if(counter == 0)  #user didn't 'select any tag
      tag = Tag.find_by_name("All")
      @news.tags << tag
    end


    # setup areas of this news
    areas = Area.all
    areas.each do |area|
      if @news.area_string.include?(area.name)
        @news.areas << area  # many-to-many relationship ==> it would be saved to DB automatically
      end
    end



    respond_to do |format|
      if @news.save
        # format.html { redirect_to(@news, :notice => 'News was successfully created.') }
        format.html { redirect_to(paper_index_path) }
        format.xml  { render :xml => @news, :status => :created, :location => @news }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @news.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /news/1
  # PUT /news/1.xml
  def update
    @news = News.find(params[:id])

    respond_to do |format|
      if @news.update_attributes(params[:news])
        format.html { redirect_to(@news, :notice => 'News was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @news.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /news/1
  # DELETE /news/1.xml
  def destroy
    @news = News.find(params[:id])
    @news.destroy

    respond_to do |format|
      format.html { redirect_to(news_index_url) }
      format.xml  { head :ok }
    end
  end

end
