# encoding: utf-8

class NewsController < ApplicationController

  # GET /news
  # GET /news.xml
  def index
    redirect_to(root_url)
    #@news = News.all.paginate(:page => params[:page], :per_page => 5)

    #respond_to do |format|
    #  format.html # index.html.erb
    #  format.xml  { render :xml => @news }
    #end
  end

  # GET /news/1
  # GET /news/1.xml
  def show
    @news = News.find_by_fb_obj_url(params[:id])

    if @news == nil
      # ealin: prevent Notice, FAQ, feedback-record not showing
      @news = News.find(params[:id])
    end
    @tags = Tag.all
    @areas = Area.all

    if @news.area_string != nil
      news_areas = @news.area_string.split("/")
    else
      news_areas = Array.new
      news_areas[0] = 'All_area'
    end

    news_tags = Array.new
    @news.tags.each_with_index do |tag, index|
      news_tags[index] = tag.name
    end

    @suggest_news = News.find_by_tags('rank', :none, nil, news_areas, news_tags,Time.now).paginate :page => 1, :per_page => 8

    # check login status,
    # prevent direct link to news page => cause exception: current_facebook_user is nil
    check_logged_in(false)

    if (current_facebook_user != nil && session[:id] != nil)
      user = User.find(session[:id])
      if (!user.watches.include?(@news))
        @news.watches.push(user)
        news_rank_action(user, @news, :watch)
      else
        news_rank_action(nil, @news, :watch)
      end
    else
      news_rank_action(nil, @news, :watch)
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @news }
    end
  end

  def like

    data = {}

    # check session id of user
    if (params[:user] == session[:id].to_s)
      user = User.find(session[:id])
      @news = News.find(params[:news])

      # check if like/unlike of user already exists
      if (params[:like] == 1.to_s)
        if (@news.unlikes.include?(user))
          @news.unlikes.delete(user)
        end
        if (!@news.likes.include?(user))
          @news.likes.push(user)
          news_rank_action(user, @news, :like)
        end
      else
        if (@news.likes.include?(user))
          @news.likes.delete(user)
        end
        if (!@news.unlikes.include?(user))
          @news.unlikes.push(user)
          news_rank_action(user, @news, :unlike)
        end
      end

      data['like_count'] = @news.likes.count
      data['unlike_count'] = @news.unlikes.count

      data['name'] = user.first_name + ' ' + user.last_name

      @news.save
    end

    respond_to do |format|
      format.json { render :json => data.to_json }
    end
  end

  def comment
    if (session[:id])
      user = User.find(session[:id])
    end

    news = News.find(params[:news_id])
    news_rank_action(user, news, :comment)

    response_str = "OK!"
    respond_to do |format|
      format.html { render  :inline => response_str }
    end
  end

  def share
    if (session[:id])
      user = User.find(session[:id])
    end

    news = News.find(params[:news_id])
    if user != nil && user.admin == true
      # set this news as Focus-News if shared by administrator
      tag = Tag.find_by_name('Focus')
      news.tags << tag
      news.save
    end

    news_rank_action(user, news, :share)
  end

  # GET /report/new
  # GET /report/new.xml
  def report

    @ret_data = Hash.new

    if (params[:url] != nil)

      # Check URL existence
      @news = News.find_by_url(params[:url].to_s)

      if (@news != nil)
        @parser_data = Hash.new
        @parser_data[:ret] = 'url exist'
      else
        # Parse data
        require 'parser/parser_main.rb'
        news_parser(params[:url])
      end

    end
    
    if(@parser_data[:title] != nil && @parser_data[:title] != "")
      @news = News.find_by_title(@parser_data[:title])
      if (@news != nil)
        @parser_data[:ret] = 'url exist'
      end
    end

    respond_to do |format|
      format.json { render :json => (@parser_data.to_json) }
    end

  end

  # Description: find user friends and update news rank
  # user => User object
  # news => News object
  # type => :like/:unlike/:watch/:report
  def news_rank_action(user, news, type)

    rank = calculate_rank(type, news)

    # update news rank
    news.rank += rank
    news.save

    if (user != nil)
      #update friendship rank
      update_my_news_rank(user, news, rank)

      user.inverse_friends.each do |friend|
        update_user_news_rank(friend, news, rank)
      end
    end
  end

  # Description: calculate rank by type and update news counts
  def calculate_rank(type, news)
    case type
      when :like
        news.like_count += 1
        return 2
      when :unlike
        news.unlike_count += 1
        return -1
      when :watch
        news.watch_count += 1
        return 1
      when :share
        news.share_count += 1
        return 4
      when :comment
        news.comment_count += 1
        return 3
      when :report
        if admin_logged_in?
          return 2
        end
        return 5
      when :focus   # ?��??��?
        return 3
    end
  end

  # Description: calculate my-news rank
  # user => User object
  # news => News object
  # type => :like/:unlike/:watch/:report
  def update_my_news_rank(user, news, rank)

    my_news_rank_records = UserNewsRank.where("user_id=? AND news_id=? AND my_news=?", user.id, news.id, true)

    if (my_news_rank_records.count != 0)
      news_rank_record = my_news_rank_records[0]
      news_rank_record.rank += rank
    else
      user.my_news.push(news)
      news_rank_record = UserNewsRank.where("user_id=? AND news_id=?", user.id, news.id).last
      news_rank_record.my_news = true
      news_rank_record.rank = rank
    end

    news_rank_record.save
  end

  # Description: calculate user-news rank
  # params:
  # user => User object
  # news => News object
  # type => :like/:unlike/:watch/:report
  def update_user_news_rank(user, news, rank)

    friend_news_rank_records = UserNewsRank.where("user_id=? AND news_id=? AND my_news=?", user.id, news.id, false)

    if (friend_news_rank_records.count != 0)
      news_rank_record = friend_news_rank_records[0]
      news_rank_record.rank += rank
    else
      user.friend_news.push(news)
      news_rank_record = UserNewsRank.where("user_id=? AND news_id=?", user.id, news.id).last
      news_rank_record.my_news = false
      news_rank_record.rank = rank
    end
    news_rank_record.save

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
    user = User.find(session[:id])
    @news.user = user

    image = Image.create(:url => params[:image_url])
    image.news = @news
    image.save

    @news.tags = []
    counter = 0
    feedback = false;
    params.each_pair do |key, value|
      if (value == 'on')
        tag = Tag.find_by_name(key)
        @news.tags << tag
        counter += 1

        if(tag.name.downcase == "feedbacktag" || tag.name.downcase == "hgtimesnotice")
          @news.special_flag= true
          if (tag.name.downcase == "feedbacktag")
            feedback = true
          else # update last notice time
            sysdata = get_system_data()
            sysdata.last_system_notice = Time.now
            sysdata.save
          end
        end
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

    if (@news.special_flag == false || feedback == true )
      news_rank_action(user, @news, :report)
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

  def set_news_today(news_id)
    news = News.find(news_id)
    news.daily_news = true
    news.save
  end

  def get_news_today(start_date, end_date)
    news = News.where(:daily_news => true, :created_at => (start_date)..(end_date))
    return news
  end



  # usage: www.heygotims.com/news/set_image?id=12345&image=http://.....
  #
  #
  def set_image
    news = News.find(params[:id])
    if news == nil
      @response = 'News ID error'
      return
    end

    if news.images[0] != nil
      news.images[0].url = params[:image] ;
      news.images[0].save
    else

      @image = Image.create(params[:image])
      @image.news = news
      @image.url = params[:image]
      @image.save
    end

    @response = 'OKOK'



  end

end
