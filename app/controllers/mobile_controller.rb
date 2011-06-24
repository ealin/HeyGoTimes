class MobileController < PaperController

  def _show_paper_content
    # params:
    # :type => latest / rank
    # :page => page num to fetch

    session[:news_type] = params[:type]
    @news = get_news(params[:type], params[:page])

    respond_to do |format|
      format.html {render :partial => 'mobile/show_paper_content', :locals => {:news => @news}}
    end
  end

end
