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

  
end
