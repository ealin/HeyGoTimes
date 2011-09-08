module ApplicationHelper
   
   # many views have search-bar, they may need some methods in search_helper.rb  
   include SearchHelper
  
  
  # Ealin: reference for Rails Helper
  # http://paulsturgess.co.uk/articles/show/49-using-helper-methods-in-ruby-on-rails
  
  #-----------------------------------------------------------------------------------
  # method: show_page_tail      (Ealin: 20110501)
  #   - 包含以下聯結: FAQ, (jobs), Privacy, Term, Support
  #-----------------------------------------------------------------------------------
  # 
  def show_page_tail
    
    render  '/layouts/show_page_tail'
  end
  #===========================================================================

   MOBILE_EXCEPTIONS = ["ipad"]
   MOBILE_BROWSERS = ["android", "ipod", "opera mini", "blackberry", "palm","hiptop","avantgo","plucker", "xiino","blazer","elaine", "windows ce; ppc;", "windows ce; smartphone;","windows ce; iemobile", "up.browser","up.link","mmp","symbian","smartphone", "midp","wap","vodafone","o2","pocket","kindle", "mobile","pda","psp","treo"]
   APPLE_MOBILE_BROWSERS = ["ipad", "ipod", "iphone"]

   def detect_Mobile_browser(type)

     agent = request.headers["HTTP_USER_AGENT"].downcase

     # check except list
     if type == :list
       MOBILE_EXCEPTIONS.each do |e|
         if agent.match(e)
           return false
         end
       end
     end

     MOBILE_BROWSERS.each do |m|
       if agent.match(m)
         return true
       end
     end
     return false
   end

   def detect_apple_browser()
     agent = request.headers["HTTP_USER_AGENT"].downcase
     APPLE_MOBILE_BROWSERS.each do |m|
       if agent.match(m)
         return true
       end
     end
     return false
   end

  #-----------------------------------------------------------------------------------
  # method: show_page_head      (Ealin: 20110502)
  #   - 包含以下聯結: to main page/ to today's newspaper / logout
  #     editor_flag = true ==>  多顯示一個'editor' link
  #-----------------------------------------------------------------------------------
  # 
  def show_page_head (option = {:faq_flag => false, :setup_flag => false, :login_flag => false} )

    # 在某些不需要LOGIN就可以使用的頁面, 必須視狀況, 顯示LOGIN的ICON
    #
    if option[:login_flag] == true
      @login_flag = true
    else
      @login_flag = false
    end


    render  '/layouts/show_page_head'
  end
  #===========================================================================

  
  def get_button(button_text, options={})
    options[:class] = "submitButton"
    submit_tag button_text, options
  end

  def get_fb_obj_url(news)
    if (news.fb_obj_url==nil)
      url = "http://www.heygotimes.com/news/"+news.id.to_s
    else
      url = "http://www.heygotimes.com/news/"+news.fb_obj_url
    end
    return url
  end

   def get_fb_obj_url_mobile(news)
     if (news.fb_obj_url==nil)
       url = "http://www.heygotimes.com/news/"+news.id.to_s
     else
       url = "http://www.heygotimes.com/news/"+news.fb_obj_url
     end
     return url
   end

end
