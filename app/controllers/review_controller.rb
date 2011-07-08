class ReviewController < NewsController

  #~~~~~~~~~~~~~~~~~~~~~prepare data for reviewing news generated by API ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  #
  #
  def tw

    # todo: must check reviewer's id (prevent normal user using this function)
    #

    # get all news which area = Taiwan & special_flag == true
    #
    areas = ["Taiwan"] ;
    tags = ["All","World","Society","Local","Politics","Life","Business","Stock","Sci_Tech",
          "Sport","Entertainment", "Health", "Internet","Travel","Education","Art","Special"] ;

    @news_for_review = News.get_all_special(areas,tags,:none,nil)

  end


  #~~~~~~~~~~~~~~~~~~~~~called by AJAX, delete a news ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  #
  #
  def delete_news

    response_str = "NG"

    #logger.debug params
    news_id = Integer(params[:news_id])
    news = News.find(news_id)

    if(news != nil)
      news.delete
      response_str = "OK"
    end

    respond_to do |format|
      format.html { render  :inline => response_str }
    end


  end

  #~~~~~~~~~~~~~~~~~~~~~called by AJAX, delete news-image and publish it ~~~~~~~~~~~~~~~~~~~~~~~
  #
  #
  def delete_img_and_publish

    response_str = "NG"

    news_id = Integer(params[:news_id])
    news = News.find(news_id)

    if(news != nil)
      images = Image.find_by_news_id(news_id)
      images.delete

      news.images = []


      news.special_flag= false
      news.save
      response_str = "OK"
    end

    respond_to do |format|
      format.html { render  :inline => response_str }
    end


  end

  #~~~~~~~~~~~~~~~~~~~~~called by AJAX, publish this news ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  #  (just set special_flag to false)
  #
  def publish_news

    response_str = "NG"

    news_id = Integer(params[:news_id])
    news = News.find(news_id)

    if(news != nil)
      news.special_flag= false
      news.save
      response_str = "OK"
    end

    respond_to do |format|
      format.html { render  :inline => response_str }
    end


  end



end
