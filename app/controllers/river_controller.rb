class RiverController < ApplicationController

  def index
    @news = News.get_all_news_today

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

end # end of RiverController
