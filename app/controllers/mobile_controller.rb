class MobileController < PaperController

  def _show_paper_content
    # params:
    # :type => latest / rank
    # :page => page num to fetch
    @loading_news_num = params[:news_num] ;

    if @loading_news_num == nil
      @loading_news_num = 10
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
