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
  




  #-------------------------------------------------------------------------------
  # method: admin_logged_in?
  #    - admin_data module would call this function before entering admin-mode
  #  https://github.com/neerajdotname/admin_data/wiki/admin_data-security-configuration-for-a-Rails3-application
  #-------------------------------------------------------------------------------
  # Todo: check ths function (admin_logged_in?) would be called back in production mode or not?
  #  (reference: config/init.../admin_controller.rb)
  #
  def admin_logged_in?
    #if session[:logged_in] == true && (session[:host_id] == 670999089 || session[:host_id] == 753452019  || session[:host_id] == 100000182246137)
    if session[:logged_in] == true && User.find(session[:id]).admin == true
      true
    else
      false
    end

  end



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

        user = User.find_by_host_id(current_facebook_user.id)
        if (user != nil) && ((Date.today - user.last_update_friends) > 0)
          get_friends(user.id)
        end

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
        session[:host_id] = user.host_id

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
           session[:host_id] = user.host_id
           get_friends(session[:id])
        else
           logger.debug "Create User-" + current_facebook_user.email + " to DB error!!"
        end

      end

    end


  end


   #===========================================================================

  #-----------------------------------------------------------------------------------
  # method: get_friends
  #   - # get user friends and save to friendship table
  #-----------------------------------------------------------------------------------
  def get_friends(id)
    facebook_cookies = Koala::Facebook::OAuth.new(Facebooker2.app_id, Facebooker2.secret).get_user_info_from_cookie(cookies)
    access_token = facebook_cookies["access_token"]
    graph = Koala::Facebook::GraphAPI.new(access_token)
    friends = graph.get_connections("me", "friends")

    user = User.find(id)

    friends.each do |friend|
      friend = User.find_by_host_id(friend["id"])
      if (friend != nil && !user.friends.include?(friend))
        user.friends << friend
      end
    end

    user.last_update_friends = Date.today
    user.save
  end


  #-----------------------------------------------------------------------------------
  # method: set_default_locale
  #   // ask server to set session[:default_locale] then reload the main-page(new_locale)
  #-----------------------------------------------------------------------------------
  def set_default_locale()

    session[:default_locale] = params[:locale]

    redirect_to root_url

    #respond_to do |format|
    #  format.html { render  :inline => "OK" }
    #end


  end





  #----------------------------------------------------
  # method: mapping_locale_to_area
  #----------------------------------------------------
  #

  def mapping_locale_to_area

    if I18n.locale == :en
      session[:default_area] = "USA"
      session[:default_locale] = 'en'
    elsif I18n.locale == :zh
      session[:default_area] = "China"
      session[:default_locale] = 'zh'
    else
      session[:default_area] = "Taiwan"
      session[:default_locale] = 'zh_tw'
    end

  end

  #===========================================================================




  # Ealin: 20110411
  #--------------------------
  # method: set_locale
  #--------------------------
  #
  def set_locale
    #logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
    #logger.debug request.env['HTTP_ACCEPT_LANGUAGE']

    if session[:default_locale] != nil
      I18n.locale = (session[:default_locale]).to_sym
      mapping_locale_to_area
      return
    end

    logger.debug "'#{I18n.locale}'"

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

    # save mapped area to session[:default_area]
    mapping_locale_to_area
  
    #logger.debug I18n.locale.length
    #logger.debug "* Locale set to '#{I18n.locale}'"
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
   
  def get_system_data
    SystemData.find(1)
  end
   
end
