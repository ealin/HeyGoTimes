class PaperController < ApplicationController
  

  def index
  
  
  end

  # Ealin: 20110411
  #--------------------------
  # method: to_main_page
  #--------------------------
  # 
 def to_main_page
    
    # link to "main_page/index" 
    #
    redirect_to  :controller => 'main_page', :action => 'index'
 end


end
