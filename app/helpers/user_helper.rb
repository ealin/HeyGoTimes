module UserHelper


  def show_logging_link (redirect_url)

    render :partial => "user/fb_logging_link", :locals => {:url => redirect_url}


   end



  def show_logout_link (redirect_url)

    render :partial => "user/fb_logout_link", :locals => {:url => redirect_url}


  end

end