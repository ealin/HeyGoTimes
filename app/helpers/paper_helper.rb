module PaperHelper
  def show_report_form
    @news = News.new

    render :partial => 'news/form', :locals => {:news => @news}
  end

  def get_river
    if (session[:logged_in] == true && session[:id] != nil)
       user = User.find(session[:id])

       if user.admin == true
         @rivers = River.where(:user_id => 2).order('position')
       end

      @rivers += user.rivers
    end

    return @rivers
  end


end
