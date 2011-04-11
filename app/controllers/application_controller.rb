class ApplicationController < ActionController::Base
  
  before_filter :set_locale
  
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
     
      #  84 == 'T',  116 == 't'
      if env['HTTP_ACCEPT_LANGUAGE'][3] == 84 || env['HTTP_ACCEPT_LANGUAGE'][3] == 116   
        #
        # Ealin: 避免繁體與簡體可能混淆, 將繁體的locale name設為zh_tw
        #
        I18n.locale = :zh_tw
      end
    end
  
    #logger.debug I18n.locale.length
    logger.debug "* Locale set to '#{I18n.locale}'"
  end
  
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
   
end
