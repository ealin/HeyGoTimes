class MobileController < PaperController

  def index
    check_logged_in(true)
  end

end
