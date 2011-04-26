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

  # Ealin: 20110426
  #----------------------------------------
  # method: filiter_today_newspaper  過濾新聞
  #----------------------------------------
  # 
 def filiter_today_newspaper
    
  logger.debug '[logging] filiter_papers executed'

 end



end
