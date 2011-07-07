class ReviewController < ApplicationController
  def tw



    # get all news which area = Taiwan & special_flag == true
    #
    @news_need_review = News.find_all_by_special_flag(true)


  end

end
