module SearchHelper

  
  # Ealin: 20110419
  #------------------------------------------------------------------------------
  # method: show_search_bar
  #  - this method would be used by some controller to show search-bar,
  #------------------------------------------------------------------------------
   def show_search_bar(type)
    # there're 4 kinds of type: :paper, :ad, :rt_news, :area
    
    if(type == :paper)
      logger.debug "[HGTimes Debug] I want to search in News Paper"
    else
      logger.debug "[HGTimes Debug] I want to search in others"     
    end
    
    # Ealin: helper.rb可以直接輸出html, 但為了安全因素字串後面要接.html_safe (否則會連tag一起輸出)
    #
    html = "" ;
    html << "Search Bar(searching " + type.to_s + ")<br>"
    html.html_safe
    
    
  end
    
  
end
