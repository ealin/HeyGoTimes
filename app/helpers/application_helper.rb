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


  #-----------------------------------------------------------------------------------
  # method: show_page_head      (Ealin: 20110502)
  #   - 包含以下聯結: to main page/ to today's newspaper / logout
  #     editor_flag = true ==>  多顯示一個'editor' link
  #-----------------------------------------------------------------------------------
  # 
  def show_page_head (option = {:faq_flag => false} )
    
    if option[:realtime_news_flag] == true
      @realtime_news_flag = true
    else
      @realtime_news_flag = false
    end
    
    # only "main_page"/"paper"/"faq"/"terms"/"privacy" pages may have "login"/"signup" link, others page should have "logout" link only.
    # (i.e. non-member could read "main_page"/"paper"/"faq"/"terms"/"privacy" pages only)
    if option[:faq_flag] == true
      @faq_flag = true
    else
      @faq_flag = false
    end   
     
    render  '/layouts/show_page_head'
  end
  #===========================================================================

  
  def get_button(button_text, options={})
    options[:class] = "submitButton"
    submit_tag button_text, options
  end

  
end
