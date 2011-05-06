class RealTimeNewsController < ApplicationController
  # Use tiny_mce editor
  uses_tiny_mce
  
  # GET /real_time_news
  # GET /real_time_news.xml
  def index
    @real_time_news = RealTimeNews.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @real_time_news }
    end
  end

  # GET /real_time_news/1
  # GET /real_time_news/1.xml
  def show
    @real_time_news = RealTimeNews.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @real_time_news }
    end
  end

  # GET /real_time_news/report
  # GET /real_time_news/report.xml
  def report
    @real_time_news = RealTimeNews.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @real_time_news }
    end
  end

  # GET /real_time_news/1/edit
  def edit
    @real_time_news = RealTimeNews.find(params[:id])
  end

  # POST /real_time_news
  # POST /real_time_news.xml
  def create
    @real_time_news = RealTimeNews.new(params[:real_time_news])

    respond_to do |format|
      if @real_time_news.save
        format.html { redirect_to(@real_time_news, :notice => 'Real time news was successfully created.') }
        format.xml  { render :xml => @real_time_news, :status => :created, :location => @real_time_news }
      else
        format.html { render :action => "report" }
        format.xml  { render :xml => @real_time_news.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /real_time_news/1
  # PUT /real_time_news/1.xml
  def update
    @real_time_news = RealTimeNews.find(params[:id])

    respond_to do |format|
      if @real_time_news.update_attributes(params[:real_time_news])
        format.html { redirect_to(@real_time_news, :notice => 'Real time news was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @real_time_news.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /real_time_news/1
  # DELETE /real_time_news/1.xml
  def destroy
    @real_time_news = RealTimeNews.find(params[:id])
    @real_time_news.destroy

    respond_to do |format|
      format.html { redirect_to(real_time_news_index_url) }
      format.xml  { head :ok }
    end
  end
end
