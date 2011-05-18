class PaperController < NewsController

  def index
     check_followed()   #一開始就要判斷目前user是否有訂閱這份報紙
     
     # for checking login status in View, we must define an obj-attribute @logged_flag and
     #    check_logged_in() in application_controller.rb
     check_logged_in()
     
     set_newspaper_size()
     get_paper_title_info()
   end


  #-----------------------------------------------------------------------------------
  # method: set_newspaper_size      (Ealin: 20110501)
  #   - （設定報紙頁面中, 一些與size有關的attributes）
  #-----------------------------------------------------------------------------------
  # 
  def set_newspaper_size
    @paper_width = 600 
    @title_height = 210
    
    @ad_width = 120
    @ad_height = 60
    @ad_no = 10
  end
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
    @news = News.all
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
  def check_followed
    # 目前的user是否有訂閱這份報紙？
    @followed_flag = false

    return @followed_flag
  end
  #===========================================================================



  # Ealin: 20110430
  #-----------------------------------------
  # method: follow
  #   - 訂閱 或 取消訂閱 這份報紙
  #-----------------------------------------
  # 
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
  #-----------------------------------------




  # Ealin: 20110411
  #--------------------------
  # method: to_main_page
  #--------------------------
  # 
 def to_main_page
    
    # link to "main_page/index" 
    #
    redirect_to  :controller => 'main_page', :action => 'index'
 end
  #-----------------------------------------


  # Ealin: 20110426
  #----------------------------------------
  # method: filiter_today_newspaper  過濾新聞
  #----------------------------------------
  # 
  def filiter_today_newspaper
    
    logger.debug '[logging] filiter_papers executed'

  end
  #-----------------------------------------



end
