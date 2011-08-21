class MobileController < PaperController

  def _show_paper_content
    # params:
    # :type => latest / rank
    # :page => page num to fetch
    temp_str = params[:news_num]
    @loading_news_num = 0

    if temp_str == nil || (temp_str != '10'&& temp_str != '15' && temp_str != '20' && temp_str != '25')
      @loading_news_num = 10
    else
      @loading_news_num = Integer(temp_str)
    end

    if params[:time_base] != nil && params[:time_base] == 'now'
      session[:news_load_time] = Time.now
    end

    user_logged_in = (session[:logged_in] == true && session[:id] != nil)? true: false

    response_need_login = false
    if params[:type] == 'friend' && user_logged_in == true
      session[:news_type] = 'rank'
      session[:filter_friend] = 'friend'
    else
      if (params[:type] == 'friend' || params[:type] == 'notation') && (user_logged_in == false)
        response_need_login = true
      else
        session[:news_type] = params[:type]
      end
    end

    if response_need_login == true
      @news = nil
    elsif session[:news_type] == 'notation'
      # get event notification
      user = User.find(session[:id])
      @news = get_notation_news(user, params[:page])
      user.last_event_notification = Time.now
      user.save
    else
      @news = get_news(session[:news_type], params[:page])
    end

    respond_to do |format|
      if @news == nil
        response_str = "<div style='color:red;'>"+t(:login_for_set_friend_filter)+"</div><hr>"
        format.html {render :inline => response_str}
      else
        format.html {render :partial => 'mobile/show_paper_content', :locals => {:news => @news}}
      end
    end
  end

   def show_news
    @news = News.find(params[:id])
    check_logged_in(false)

    if (current_facebook_user != nil)
      user = User.find(session[:id])
      if (!user.watches.include?(@news))
        @news.watches.push(user)
        news_rank_action(user, @news, :watch)
      end
    end

    respond_to do |format|
      format.html {render :partial => 'show_news', :locals => {:news => @news, :redirect_from_web => params['redirect_from_web']}}
    end
  end

end
