class PaperController < ApplicationController
  
  def index
     followed   #一開始就要判斷目前user是否有訂閱這份報紙
  end


  # Ealin: 20110430
  #-----------------------------------------
  # method: follow
  #   - 目前的user是否有訂閱這份報紙？
  #-----------------------------------------
  # 
  def followed
    # 目前的user是否有訂閱這份報紙？
    @followed_flag = false

     logger.debug "判斷目前user是否有訂閱這份報紙"
     return @followed_flag
  end
  #-----------------------------------------


  # Ealin: 20110430
  #-----------------------------------------
  # method: follow
  #   - 訂閱 或 取消訂閱 這份報紙
  #-----------------------------------------
  # 
  def follow 

    if params[:flag] == "true"
      if @followed_flag == false
        logger.degug "新增訂戶"
        @followed_flag = true
      end
    else   
     if @followed_flag == true
        logger.degug "取消訂戶"
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
