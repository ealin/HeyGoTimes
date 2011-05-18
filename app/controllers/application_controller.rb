class ApplicationController < ActionController::Base

  include Facebooker2::Rails::Controller
  
  # Ealin: �?iew & helper ?��?以�??�redirect_to()
  #
  helper_method :redirect_to
  
  before_filter :set_locale
  
 

  #----------------------------------------------------
  # method: check_logged_in   (Ealin: 20110430)
  #----------------------------------------------------
  # 
  def check_logged_in
    
    return session[:logged_in] ;
    
  end
  #===========================================================================


  #----------------------------------------------------
  # method: get_current_user_info   (Ealin: 20110510)
  #----------------------------------------------------
  #
  def get_current_user_info

    #  Ealin: 以�?�????���?20110510)

    @user_account = "ealin.chiu@gmail.com"
    @user_account_connected_to = "facebook"

    # 1 account has MAX 3 email-address
    @email_for_subscription = "ealin@yahoo.com.tw"

    # ???使�?????��??��???��  (read from database)
    @user_subscribed_paper_no = 4
    @user_subscribed_paper = Array.new
    @user_subscribed_paper[0] = "Taiwan"
    @user_subscribed_paper[1] = "Silicon Valley"
    @user_subscribed_paper[2] = "?�山�?��?��?"
    @user_subscribed_paper[3] = "7-11?��??��?"


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
  #def signup
  # render "/user/signup"
  #end
  #===========================================================================


  
  # Ealin: 20110411
  #--------------------------
  # method: set_locale
  #--------------------------
  # 
  def set_locale
    #logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
    #logger.debug request.env['HTTP_ACCEPT_LANGUAGE']
    I18n.locale = extract_locale_from_accept_language_header

    #logger.debug "'#{I18n.locale}'"

    if I18n.locale == :"zh" 
   
      logger.debug env['HTTP_ACCEPT_LANGUAGE'][3]
      #  Ealin: 84 == 'T' (?��????: zh_TW), 116 == 't' (?��????: zh-tw)
      if env['HTTP_ACCEPT_LANGUAGE'][3] == 84 || env['HTTP_ACCEPT_LANGUAGE'][3] == 116

        #
        # Ealin: ?��?�????���???�混�? �??�??locale name設�?zh_tw
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
  #   - �??logo icon?????? => 大�?????��??�跳??paper, ??paper???跳�?/main_page 
  #     (?��?paper_controller??verriding???method, ?��?controller?��??��?�??????????)
  #-----------------------------------------------------------------------------------
  #
  def to_main_page
    redirect_to :controller => 'paper', :action => 'index' 
  end  
  #-----------------------------------------------------------------------------------------
  


  # Ealin: 20110505
  #-----------------------------------------------------------------------------------
  # method: to_mobile_site
  #   �???��?�??覽模�?(URL should looks like:   m.heygotimes.com/xxx/yy)
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
