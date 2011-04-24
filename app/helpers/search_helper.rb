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
    
    #Ealin: render  Partial Layout - _search_bar.html.erb
    render "/search/search_bar"
 

    
  end
    
  
end
