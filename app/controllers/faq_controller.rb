class FaqController < ApplicationController
  def index
     # for checking login status in View, we must define an obj-attribute @logged_flag and
     #    check_logged_in() in application_controller.rb    
    check_logged_in
    
    # TBD.
    #
    @question_frame_width = 500
    @answer_frame_width = 300
    
  end

  #-----------------------------------------------------------------------------------
  # method: show_question_list      (Ealin: 20110506)
  #-----------------------------------------------------------------------------------
  # 
  def show_question_list

      render :layout => nil
   
  end

  #===========================================================================



  #-----------------------------------------------------------------------------------
  # method: show_answer      (Ealin: 20110506)
  #-----------------------------------------------------------------------------------
  # 
  def show_answer

      render :layout => nil
   
  end

  #===========================================================================



end
