class DailyController < PaperController

  # select daily news manually
  def select
    # - must check reviewer's id (prevent normal user using this function)
    #
    if !(admin_logged_in?)
      render  :inline => "You got no right to enter this page!"
      return
    end

    @ret_msg = "Usage: root_url/daily/select?id=12345"

    if params[:id] != nil

      # set daily_news flag for news with decided ID
      begin
        news = News.find(Integer(params[:id]))
        news.daily_news=true
        news.river_event = true
        news.save

        river = River.find(1)
        event = RiverEvent.new
        event.news = news
        event.event_dt = news.created_at
        event.river = river
        event.save

        @ret_msg2 = "Daily News selected - Date = " + news.created_at.in_time_zone("Taipei").strftime("%Y/%m/%d")
      rescue Exception => e
        @ret_msg2 = ("ID " + params[:id] + " not found")
      end


    end

  end

end
