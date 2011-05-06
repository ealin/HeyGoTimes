class MainPageController < ApplicationController
  def index
    
     # for checking login status in View, we must define an obj-attribute @logged_flag and
     #    check_logged_in() in application_controller.rb    
    check_logged_in
  end

end
