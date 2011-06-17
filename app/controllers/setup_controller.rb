class SetupController < ApplicationController
  def index
     # for checking login status in View, we must define session[:logged_in] and
     #    check_logged_in() in application_controller.rb    
     check_logged_in

     # also defined in in application_controller.rb, it will set following obj-variables:
     #  -@user_account, @user_account_connected_to, @user_account_email[0~2]
     #
     #get_current_user_info


  end


  #----------------------------------------------------
  # method: deactive_fb_account   (Ealin: 20110510)
  #    取消與facebook帳號的連結
  #----------------------------------------------------
  #
  def deactive_fb_account
     #TBD

  end


  #----------------------------------------------------
  # method: connect_twitter_account   (Ealin: 20110510)
  #    建立與twitter帳號的連結
  #----------------------------------------------------
  #
  def connect_twitter_account
    #TBD

  end


  #----------------------------------------------------
  # method: modify_email   (Ealin: 20110510)
  #    修改既有的EMAIL帳號
  #----------------------------------------------------
  #
  def modify_email
    #TBD

  end


  #----------------------------------------------------
  # method: cancel_subscription   (Ealin: 20110512)
  #    取消訂閱
  #----------------------------------------------------
  #
  def cancel_subscription

  end

  #----------------------------------------------------
  # method: set_filter   (Ealin: 20110512)
  #     過濾新聞 (USER可選擇其有興趣的TAG)
  #----------------------------------------------------
  #
  def set_filter
    logger.debug params[:area]
    @current_subscription = params[:area]

  end


  #----------------------------------------------------
  # method: set_default_paper   (Ealin: 20110512)
  #      設定預設報紙 (打開首頁, 預設會載入的報紙)
  #----------------------------------------------------
  #
  def set_default_paper

  end


end
