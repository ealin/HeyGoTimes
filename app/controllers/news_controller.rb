class NewsController < ApplicationController
  # Use tiny_mce editor
  uses_tiny_mce

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

      # check if like/dislike of user already exists
      if (params[:like] == 1.to_s)
        if (@news.dislikes.include?(@user))
          @news.dislikes.delete(@user)
        end
        @news.likes.push(@user)
        @data['total'] = @news.likes.count
      else
        if (@news.likes.include?(@user))
          @news.likes.delete(@user)
        end
        @news.dislikes.push(@user)
        @data['total'] = @news.dislikes.count
      end

      # calculate rank
      @like_count = @news.likes.count
      @dislike_count = @news.dislikes.count

      if (@like_count > @dislike_count)
        @news.rank = @like_count - @dislike_count
      end

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
      # @url = 'http://www.facebook.com/sharer.php?u=' + params[:url]
      @url = 'http://developers.facebook.com/tools/lint/?url=' + params[:url]

      require 'nokogiri'
      require 'open-uri'

      @next = ''
      @doc = Nokogiri::HTML(open(@url))
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

    @tags = ""
    params.each_pair do |key, value|
      if (value == 'on')
        @tag = Tag.find_by_name(key)
        @news.tags << @tag
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
