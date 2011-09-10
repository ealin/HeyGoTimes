class DailyController < PaperController

  # select daily news manually
  def select
    # - must check reviewer's id (prevent normal user using this function)
    #
    if !(admin_logged_in?)
      render  :inline => "You got no right to enter this page!"
      return
    end

    if params[:id] == nil
      @ret_msg = "usage: root_url/daily/select?id=12345"
    else
      @ret_msg = "ID = " + params[:id]
    end

  end

end
