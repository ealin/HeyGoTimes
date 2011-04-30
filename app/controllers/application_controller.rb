class ApplicationController < ActionController::Base
  
  before_filter :set_locale
  
  
  #--------------------------------------
  # Attributes definition:
  #--------------------------------------

  # current user 是否已經login (要使用session的功能) 
  @logged_flag = true

  #-----------------------------------------------------------------------------------------


  #def initialize
  #  logger.debug "[Application controller- initialize method]"
  #end


  # Ealin: 20110430
  #--------------------------
  # method: login
  #--------------------------
  # 
  def login
  
   
   render "/user/login"
  end
  #-----------------------------------------------------------------------------------------

  # Ealin: 20110430
  #--------------------------
  # method: logout
  #--------------------------
  # 
  def logout
    
   render "/user/logout"
  end
  #-----------------------------------------------------------------------------------------


  # Ealin: 20110430
  #--------------------------
  # method: signup
  #--------------------------
  # 
  def signup
    
    
   render "/user/signup"
  end
  #-----------------------------------------------------------------------------------------

  
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
