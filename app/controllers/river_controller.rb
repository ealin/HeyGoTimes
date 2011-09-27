class RiverController < ApplicationController

  def index
    @river_count = 2
    @river = River.find(1)
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

end # end of RiverController
