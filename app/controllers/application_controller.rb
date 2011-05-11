class ApplicationController < ActionController::Base
  
  # Ealin: 讓view & helper 都可以呼叫redirect_to()
  #
  helper_method :redirect_to
  
  before_filter :set_locale
  
 

  #----------------------------------------------------
  # method: check_logged_in   (Ealin: 20110430)
  #----------------------------------------------------
  # 
  def check_logged_in
    # cehck status of session, then store it to class-variable - @@logged_flag  
   
    
    # 紀錄current user 是否已經login (要使用session的功能, session should be stored in database) 
    # (all controllers in this system would have attribute - "@logged_flag")
    @logged_flag = true
    
    return @logged_flag
    
  end
  #===========================================================================


  #----------------------------------------------------
  # method: get_current_user_info   (Ealin: 20110510)
  #----------------------------------------------------
  #
  def get_current_user_info

    #  Ealin: 以下變數先寫死(20110510)

    @user_account = "ealin.chiu@gmail.com"
    @user_account_connected_to = "facebook"

    # 1 account has MAX 3 email-address
    @user_account_email = Array.new
    @user_account_email[0] = "ealin.chiu@gmail.com"
    @user_account_email[1] = "ealin@yahoo.com.tw"
    @user_account_email[2] = nil

    # 取得使用者訂閱的報紙列表  (read from database)
    @user_subscribed_paper_no = 4
    @user_subscribed_paper = Array.new
    @user_subscribed_paper[0] = "Taiwan"
    @user_subscribed_paper[1] = "Silicon Valley"
    @user_subscribed_paper[2] = "松山高中校刊"
    @user_subscribed_paper[3] = "7-11特價報導"




    #statistics data:
    @report_no = 10
    @comment_no = 5
    @edit_no = 3
    @follow_no = 6
    @fans_no = 100
    @ad_no = 6

  end
  #===========================================================================


 
  #----------------------------------------------------
  # method: login   (Ealin: 20110430)
  #----------------------------------------------------
  # 
  def login
  
   
   render "/user/login"
  end
  #===========================================================================


  #----------------------------------------------------
  # method: logout   (Ealin: 20110430)
  #----------------------------------------------------
  # 
  def logout
    
   render "/user/logout"
  end
  #===========================================================================


  #----------------------------------------------------
  # method: signup   (Ealin: 20110430)
  #----------------------------------------------------
  # 
  def signup
    
    
   render "/user/signup"
  end
  #===========================================================================


  
  # Ealin: 20110411
  #--------------------------
  # method: set_locale
  #--------------------------
  # 
  def set_locale
    logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
    I18n.locale = extract_locale_from_accept_language_header
  
    #logger.debug "'#{I18n.locale}'"
  
    if I18n.locale == :"zh" 
   
      logger.debug env['HTTP_ACCEPT_LANGUAGE'][3]
      #  Ealin: 84 == 'T' (特別處理: zh_TW)
      if env['HTTP_ACCEPT_LANGUAGE'][3] == 84 || env['HTTP_ACCEPT_LANGUAGE'][3] == 'T'  

        #
        # Ealin: 避免繁體與簡體可能混淆, 將繁體的locale name設為zh_tw
        #
        I18n.locale = :zh_tw
      end
    end
  
    #logger.debug I18n.locale.length
    logger.debug "* Locale set to '#{I18n.locale}'"
  end
  #-----------------------------------------------------------------------------------------
  
  
  # Ealin: 20110419
  #-----------------------------------------------------------------------------------
  # method: to_main_page
  #   - 點到logo icon時的動作 => 大部分畫面都是跳到/paper, 在/paper時要跳到/main_page 
  #     (只有paper_controller會overriding這個method, 其他controller直接用父類別的這個功能 )
  #-----------------------------------------------------------------------------------
  #
  def to_main_page
    redirect_to :controller => 'paper', :action => 'index' 
  end  
  #-----------------------------------------------------------------------------------------
  


  # Ealin: 20110505
  #-----------------------------------------------------------------------------------
  # method: to_mobile_site
  #   轉換為手機瀏覽模式 (URL should looks like:   m.heygotimes.com/xxx/yy)
  #-----------------------------------------------------------------------------------
  #
   def to_mobile_site
    redirect_to :controller => 'paper', :action => 'index' 
  end  
  #-----------------------------------------------------------------------------------------


  
  protect_from_forgery
  
 
  
  private


  # Ealin: 20110411
  #----------------------------------------------------
  # method: extract_locale_from_accept_language_header
  #----------------------------------------------------
  #
  def extract_locale_from_accept_language_header
    # One source of client supplied information would be an Accept-Language HTTP header. 
    # People may set this in their browser
    
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    #request.env['HTTP_ACCEPT_LANGUAGE']
  end   
  #-----------------------------------------------------------------------------------------
   
  
  

   
end
