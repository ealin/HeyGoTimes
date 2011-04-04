class ApplicationController < ActionController::Base
  
  before_filter :set_locale
  
  #
  #-------------
  # method: set_locale
  #-------------
  #
  
  #def set_locale
    # if params[:locale] is nil then I18n.default_locale will be used
  #  I18n.locale = params[:locale]
  #end  

  def set_locale
    logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
    I18n.locale = extract_locale_from_accept_language_header
	
	# rename - zh-tw ==> zh_tw
	#
	if I18n.locale == :"zh" #-tw" || I18n.locale == :"zh-TW"
     
    if env['HTTP_ACCEPT_LANGUAGE'][3] == 84   #  84 == 'T'
		  I18n.locale = :zh_tw
    end
	end
	
	#logger.debug I18n.locale.length
	
    logger.debug "* Locale set to '#{I18n.locale}'"
	
	
  end
  
  protect_from_forgery
  
 
  
  private


  #
  #-------------
  # method: extract_locale_from_accept_language_header
  #-------------
  #
  def extract_locale_from_accept_language_header
	# One source of client supplied information would be an Accept-Language HTTP header. 
	# People may set this in their browser
    
	request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
	#request.env['HTTP_ACCEPT_LANGUAGE']
  end   
	 
end
