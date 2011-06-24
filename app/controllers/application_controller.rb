class ApplicationController < ActionController::Base

  include Facebooker2::Rails::Controller

  # protect_from_forgery

  before_filter :parse_facebook_cookies
  def parse_facebook_cookies
   @facebook_cookies = Koala::Facebook::OAuth.new.get_user_info_from_cookie(cookies)
  end
  
  # Ealin: 讓view & helper 都可以呼叫redirect_to()
  #
  helper_method :redirect_to
  
  before_filter :set_locale
  
 

  #-----------------------------------------------------------
  # method: check_logged_in (Ealin: 20110430)
  #     - create_account_flag : if true ==> 必要時建立USER帳號
  #-----------------------------------------------------------
  #
  def check_logged_in(create_account_flag = false)


    # check status of logging-in FB or not

   session[:logged_in] = false
   #if !(current_facebook_user.nil?)
      begin
        current_facebook_user.fetch

        session[:logged_in] = true

      rescue Exception => e

        # OAuthException : user主動自FACEBOOK中LOGOUT
        #
        set_fb_cookie(nil,nil,nil,nil)

        session[:logged_in] = false

      end
   # else
   #   session[:logged_in] = false
   #end


    # if logged-in FB, 判斷此USER是否已經建立帳號
    #  (account should be: current_facebook_user.email & current_facebook_user.id )
    #    YES: 從DB載入USER, 將重要訊息放在SESSION中
    #    NO: create account (if necessary)

    if session[:logged_in] == true && create_account_flag == true

      session[:id] = nil

      # search USER DB with host_id field
      user = User.find_by_host_id(current_facebook_user.id)

      if user != nil
        # already existed
        session[:id] = user.id

      else

        # create a new account with: current_facebook_user. first_name, last_name, locale, birthday...
        user = User.new(:first_name => current_facebook_user.first_name, \
                      :last_name => current_facebook_user.last_name,
                      :host_account => current_facebook_user.email,
                      :birthday => current_facebook_user.birthday,
                      :host_id => current_facebook_user.id,
                      :host_site => 1,           # 1: facebook, 2: twitter
                      :locale => current_facebook_user.locale
)
        if user.save!
           session[:id] = user.id
        else
           logger.debug "Create User-" + current_facebook_user.email + " to DB error!!"
        end

      end

    end


    

  end


  #===========================================================================

=begin
  #----------------------------------------------------
  # method: get_current_user_info (Ealin: 20110510)
  #----------------------------------------------------
  #
  def get_current_user_info

    @user = User.find(session[:id])
    if @user != nil
      logger.debug "[Database Access Error:] - @ get_current_user_info() "
      return
    end

    # Ealin: 以下變數先寫死(20110510)

    #statistics data:
    @report_no = 10
    @comment_no = 5
    @follow_no = 6
    @fans_no = 100
    @ad_no = 6

  end
  #===========================================================================
=end

 
  #----------------------------------------------------
  # method: login (Ealin: 20110430)
  #----------------------------------------------------
  #
  def login


   render "/user/login"
  end
  #===========================================================================


  #----------------------------------------------------
  # method: logout (Ealin: 20110430)
  #----------------------------------------------------
  #
  def logout

   render "/user/logout"
  end
  #===========================================================================


  #----------------------------------------------------
  # method: signup (Ealin: 20110430)
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

    logger.debug "'#{I18n.locale}'"

    if I18n.locale == :"zh"
   
      logger.debug env['HTTP_ACCEPT_LANGUAGE'][3]
      # Ealin: 84 == 'T' (特別處理: zh_TW)
      if env['HTTP_ACCEPT_LANGUAGE'][3] == 84 || env['HTTP_ACCEPT_LANGUAGE'][3] == 116   ||    \
         env['HTTP_ACCEPT_LANGUAGE'][3] == 'T'  || env['HTTP_ACCEPT_LANGUAGE'][3] == 't'

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
  # - 點到logo icon時的動作 => 大部分畫面都是跳到/paper, 在/paper時要跳到/main_page
  # (只有paper_controller會overriding這個method, 其他controller直接用父類別的這個功能 )
  #-----------------------------------------------------------------------------------
  #
  def to_main_page
    redirect_to :controller => 'paper', :action => 'index'
  end
  #-----------------------------------------------------------------------------------------
  


  # Ealin: 20110505
  #-----------------------------------------------------------------------------------
  # method: to_mobile_site
  # 轉換為手機瀏覽模式 (URL should looks like: m.heygotimes.com/xxx/yy)
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
    if (request.env['HTTP_ACCEPT_LANGUAGE'] != nil)
      request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
      #request.env['HTTP_ACCEPT_LANGUAGE']
    end
  end
  #-----------------------------------------------------------------------------------------
   
  
  

   
end
