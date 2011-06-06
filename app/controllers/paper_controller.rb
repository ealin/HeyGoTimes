class PaperController < NewsController

  def index
    @news = get_news()

    @tags = Tag.all


    # for checking login status in View, we must define an obj-attribute @logged_flag and
    #    check_logged_in() in application_controller.rb
    check_logged_in(true)
    get_paper_title_info()

=begin
    # Ealin: not necessary for new-spec.
    #check_followed()   #一開始就要判斷目前user是否有訂閱這份報紙
    #set_newspaper_size()

    # keep all filters in session
    #
    #session[:filter_tags] = "All"  or "Sport/NBA/"
    #session[:filter_date] ="1971-11-12"   # "1971-11-12" means no filter for date
    #session[:filter_date_option] ="yesterday"   # possible value= "no_limited","today","yesterday","selected_date"
    #session[:filter_friend] = "all"       # possible filters are: "all", "mine", "friend"
=end

   end

  def get_news
    @news = News.all
    return @news
  end

  #-----------------------------------------------------------------------------------
  # method: set_newspaper_size      (Ealin: 20110501)
  #   - （設定報紙頁面中, 一些與size有關的attributes）
  #-----------------------------------------------------------------------------------
=begin
  def set_newspaper_size
    @paper_width = 600
    @title_height = 210

    @ad_width = 120
    @ad_height = 60
    @ad_no = 10
  end
=end
  #===========================================================================
 
 
  #-----------------------------------------------------------------------------------
  # method: get_paper_title_info      (Ealin: 20110430)
  #   - （取得 報紙title 裡的資訊 - 報紙名/slogan/date/weather/type...）
  #-----------------------------------------------------------------------------------
  # 
  def get_paper_title_info
    #
    # Ealin: should access database here
    #
    @newspaper_title = t :sample_paper_name
    @newspaper_slogan = t :sample_paper_slogan
    @weather = :Thunderstorms  # need to define
    @layout_style = :normal    # need to define
    
    temp_time = Time.new
    @date = temp_time.inspect

  end

  #===========================================================================


  #-----------------------------------------------------------------------------------
  # method: get_paper_title_info      (Ealin: 20110430)
  #   - （取得 報紙title 裡的資訊 - 報紙名/slogan/date/weather/type...）
  #-----------------------------------------------------------------------------------
  # 
  def show_paper_title
    #get newspaper's title
    get_paper_title_info()
   
    # render _show_paper_title.html.erb
    render :layout => nil
    
    
  end

  #===========================================================================



  #-----------------------------------------------------------------------------------
  # method: show_paper_content      (Ealin: 20110501)
  #   - 顯示本日報紙的內容
  #-----------------------------------------------------------------------------------
  # 
  def show_paper_content

     # render _show_paper_content.html.erb
     render :layout => nil
   
  end

  #===========================================================================



  #-----------------------------------------------------------------------------------
  # method: show_ad_list      (Ealin: 20110501)
  #   - 顯示本日報紙的內容
  #-----------------------------------------------------------------------------------
  # 
  def show_ad_list

     # render _show_ad_list.html.erb
     render :layout => nil
   
  end

  #===========================================================================


  #-----------------------------------------------------------------------------------
  # method: show_fun_buttons      (Ealin: 20110501)
  #   - （Show functional buttons : 1.Report_a_news/2.Edit_realtimes_news/3.my_AD
  #-----------------------------------------------------------------------------------
  # 
  def show_fun_buttons
   
   
    # render _show_paper_title.html.erb
    render :layout => nil
    
  end

  #===========================================================================


  #---------------------------------------------------------
  # method: check_followed
  #   - 目前的user是否有訂閱這份報紙？  (Ealin: 20110430)
  #---------------------------------------------------------
  #
=begin
  def check_followed
    # 目前的user是否有訂閱這份報紙？
    @followed_flag = false

    return @followed_flag
  end
=end
  #===========================================================================



  # Ealin: 20110430
  #-----------------------------------------
  # method: follow
  #   - 訂閱 或 取消訂閱 這份報紙
  #-----------------------------------------
  #
=begin
  def follow 

    if params[:flag] == "true"
      if @followed_flag == false
        #logger.degug "新增訂戶"
        @followed_flag = true
      end
    else   
     if @followed_flag == true
        #logger.degug "取消訂戶"
        @followed_flag = false
      end      
    end    

  end
=end
  #-----------------------------------------




  # Ealin: 20110411
  #--------------------------
  # method: to_main_page
  #--------------------------
  #
=begin
 def to_main_page
    
    # link to "main_page/index" 
    #
    redirect_to  :controller => 'main_page', :action => 'index'
 end
=end
  #-----------------------------------------


  # Ealin: 20110426
  #----------------------------------------
  # method: filiter_today_newspaper  過濾新聞
  #----------------------------------------
  #
=begin
  def filiter_today_newspaper
    
    logger.debug '[logging] filiter_papers executed'

  end
=end
  #-----------------------------------------


  # Ealin: 20110604
  #-------------------------------------------------------------------------------------
  # method: set_filter_setting
  #  - this method would be called by ajax in paper/_show)news_filter.html.erb
  #-------------------------------------------------------------------------------------
  #
  def set_filter_setting
    session[:filter_tags] = params[:tag_filter]

    if(params[:friend_filter] == "")
      session[:filter_friend] = "all"
    else
      session[:filter_friend] = params[:friend_filter]
    end

    session[:filter_date] = params[:date_filter]
    session[:filter_date_option] = params[:date_filter_option]

    response_str = t(:filter_setting_saved)
    if(params[:save] == "yes")
      # save the filter setting in DB

      user = User.find(session[:id])
      if(user == nil)
        response_str = t(:user_not_exist)
      end

      # setup user.tags
      #
      user.tags = []
      tags = Tag.all
      tags.each do |tag|
        if (session[:filter_tags]).include?(tag.name)
          user.tags << tag  # many-to-many relationship ==> it would be saved to DB automatically
        end
      end

      # setup user.date_filter
      #
      temp_date_filter = DateFilter.new(:date => session[:filter_date], :option => session[:filter_date_option])
      temp_date_filter.save
      user.date_filter = temp_date_filter


      #user.date_filter


    end

    #logger.debug "[logging]Filter setting saved in session!"

    # IMPORTANT: it must response something to browser, or the session would not be saved in cookie!!!
    #
    respond_to do |format|
      format.html { render  :inline => response_str }
      #format.html { render  :partial => "paper/ack" }
    end


    # redraw the paper page  <=== caller (JS code in _show_news_filter.html.erb would do this job!)

  end




  # Ealin: 20110604
  #-------------------------------------------------------------------------------------
  # method: get_filter_session
  #  - seed back all session to filter-dialog
  #-------------------------------------------------------------------------------------
  #
  def get_filter_session


    respond_to do |format|
      format.json { render :json => session.to_json }
    end

  end

end
