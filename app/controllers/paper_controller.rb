class PaperController < ApplicationController
  
  
  def index
     
     #一開始就要判斷目前user是否有訂閱這份報紙
     check_followed   
     
     # for checking login status in View, we must define an obj-attribute @user_login here. 
     # check_logged_in() is defined in application_controller.rb
     @user_login = check_logged_in
     
     #get newspaper's title
     get_paper_title_info
     
  end


 
  #-----------------------------------------------------------------------------------
  # method: get_paper_title_info      (Ealin: 20110430)
  #   - （取得 報紙title 裡的資訊 - 報紙名/slogan/date/weather/type...）
  #-----------------------------------------------------------------------------------
  # 
  def get_paper_title_info
    #
    # Ealin: should access database here
    #
    @newspaper_title = "北台灣日報"
    @newspaper_slogan = "最權威完整的網路報紙"
    @weather = :Thunderstorms  # need to define
    @layout_style = :normal    # need to define
    
    temp_time = Time.new
    @date = temp_time.inspect

  end

  #===========================================================================



  # Ealin: 20110430
  #-----------------------------------------
  # method: follow
  #   - 目前的user是否有訂閱這份報紙？
  #-----------------------------------------
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

  end
  #-----------------------------------------




  # 
 def to_main_page
    
    #
    redirect_to  :controller => 'main_page', :action => 'index'
 end
  #-----------------------------------------


  #----------------------------------------
  #----------------------------------------
  # 
  def filiter_today_newspaper
    
    logger.debug '[logging] filiter_papers executed'

  end
  #-----------------------------------------

end



