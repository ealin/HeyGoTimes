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

    session[:news_type] = params[:type]
    @news = get_news(params[:type], params[:page])

    respond_to do |format|
      format.html {render :partial => 'mobile/show_paper_content', :locals => {:news => @news}}
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
