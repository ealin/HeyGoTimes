class RiverController < ApplicationController

  def index

    @rivers = River.all
    @river_count = @rivers.count
    #@news = News.get_all_news_today
  end

  # load next followed river
  def next_follow
  end

  # load previous followed river
  def prev_follow
  end

  # suggest follow list
  def suggest_follow
  end

  # get next event
  def forward
  end

  # get earlier event
  def backward
  end

  # get my news for event news substitution
  def user_news_by_date
  end

  # prepare river data
  def prepare_river_data
    river = River.find(1)
    daily_news = News.get_all_news_today
    daily_news.each do |news|
      event = RiverEvent.new
      event.news = news
      event.event_dt = news.created_at
      event.river = river
      event.save
      news.river_event = true
      news.save
    end
  end

  def select_event
    # - must check reviewer's id (prevent normal user using this function)
    #
    if !(admin_logged_in?)
      render  :inline => "You got no right to enter this page!"
      return
    end

    @ret_msg = "Usage: root_url/river/select_event?id=12345&r_id=1"

    if params[:id] != nil

      # set daily_news flag for news with decided ID
      begin
        news = News.find(Integer(params[:id]))
        news.river_event = true
        news.save

        river = River.find(Integer(params[:r_id]))
        event = RiverEvent.new
        event.news = news
        event.event_dt = news.created_at
        event.river = river
        event.save

        @ret_msg = "River event selected - river: " + river.name
      rescue Exception => e
        @ret_msg = ("ID " + params[:id] + " not found")
      end
    end

  end

end # end of RiverController
