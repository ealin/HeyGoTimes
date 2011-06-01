class NewsController < ApplicationController
  # Use tiny_mce editor
  uses_tiny_mce

  # GET /news
  # GET /news.xml
  def index
    @news = News.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @news }
    end
  end

  # GET /news/1
  # GET /news/1.xml
  def show
    @news = News.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @news }
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
        puts data.content

        if (data.content == 'Description')
          @next = :content
          next
        elsif (data.content == 'Title')
          @next = :title
          next
        end

        if (@next == :content)
          @text = data.content

        elsif (@next == :title)
          @title = data.content
          break
        end

        @next = :normal
      end

      @data['title']=@title.to_s
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
