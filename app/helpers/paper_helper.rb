module PaperHelper
  def show_report_form
    @news = News.new

    render :partial => 'news/form', :locals => {:news => @news}
  end

end
