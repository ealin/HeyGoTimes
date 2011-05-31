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
      @url = 'http://www.facebook.com/sharer.php?u=' + params[:url]

      require 'nokogiri'
      require 'open-uri'

      # @uri = "www.facebook.com/sharer.php?u=http://www.littleshell.net&t=littleshell的網站"
      @doc = Nokogiri::HTML(open(@url))
      # @body = @doc.at_css('body').text
      @title = @doc.search('div.UIShareStage_Title')
      # UIShareStage_Summary
      # @data['title']="塑化劑風暴／塑化劑嚴重　衛署追查化妝保養品-Yahoo!奇摩新聞"
      # @data['text'] = @title

      @data['title']="塑化劑風暴／塑化劑嚴重　衛署追查化妝保養品-Yahoo!奇摩新聞"
      @data['text']="塑化劑風暴更擴大了，現在不只是食品，就連指甲油、香水、化妝品、乳液等保養品都牽連危機！彰化衛生局上午到屈臣氏抽查相關化妝品，要檢驗是否含塑化劑，國家衛生研究院最近更首度...."
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

    respond_to do |format|
      if @news.save
        format.html { redirect_to(@news, :notice => 'News was successfully created.') }
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
