class SearchController < ApplicationController
  def index
  end

  def do_search
    logger.debug "[Searching...]"
    logger.debug params[:text]
  end

end
