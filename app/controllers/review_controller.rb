class ReviewController < NewsController

  #~~~~~~~~~~~~~~~~~~~~~prepare data for reviewing news generated by API ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  #
  #
  def tw

    # - must check reviewer's id (prevent normal user using this function)
    #
    if !(admin_logged_in?)
      render  :inline => "You got no right to enter this page!"
      return
    end

    # get all news which area = Taiwan & special_flag == true
    #
    areas = ["Taiwan"] ;
    tags = ["All","World","Society","Local","Politics","Life","Business","Stock","Sci_Tech",
          "Sport","Entertainment", "Health", "Internet","Travel","Education","Art","Special"] ;


    @news_for_review = News.get_all_special(areas,tags,:none,nil)
    @count = @news_for_review.count

  end



  #~~~~~~~~~~~~~~~~~~~~~prepare data for reviewing spam ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  #
  #
  def spam
    # - must check reviewer's id (prevent normal user using this function)
    #
    if !(admin_logged_in?)
      render  :inline => "You got no right to enter this page!"
      return
    end

    # get all news which area = Taiwan & special_flag == true
    #
    areas = ["Taiwan"] ;
    tags = ["FeedbackTag"] ;

    @spam_news = []

    @spam_report = News.get_all_special(areas,tags,:none,nil)
    @count = @spam_report.count

    @spam_report.each do |report|
       id = Integer((report.title)[('[SPAM REPORT]ID='.length)..(report.title).length])

      @spam_news << (News.find(id))

    end

  end



  #~~~~~~~~~~~~~~~~~~~~~called by AJAX, report a spam ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  #
  #
  def report_spam

    response_str = t(:report_spam_ng)

    news_id = Integer(params[:news_id])
    news = News.find(news_id)

    if(news != nil)

      report = News.new
      report.title= '[SPAM REPORT]ID='+params[:news_id]

      area = Area.find_by_name(session[:default_area])
      report.areas << area

      tag = Tag.find_by_name('FeedbackTag')
      report.tags << tag

      report.images = []

      user = User.find(session[:id])
      user.my_news << report

      news_rank_record = UserNewsRank.where("user_id=? AND news_id=?", user.id, report.id).last
      news_rank_record.my_news = true
      news_rank_record.save

      content = t(:news_title) + news.title + "<br><br>" + (params[:content]).toutf8
      report.content = content

      report.special_flag= true
      report.area_string= session[:default_area] + '/'
      report.user = user


      report.save


      response_str = t(:report_spam_done)
    end

    respond_to do |format|
      format.html { render  :inline => response_str }
    end

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
      if(images != nil)
        images.delete
        news.images = []
      end
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




  #~~~~~~~~~~~~~~~~~~~~~called by AJAX, jump to admin_data page to change the image ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  #
  #
  def change_image

    response_str = "NG"
    url = root_url + "admin_data/klass/image/"

    news_id = Integer(params[:news_id])
    news = News.find(news_id)

    if(news != nil)
      images = Image.find_by_news_id(news_id)
      url += (images.id).to_s
      url += "/edit"

      response_str = url
    end

    respond_to do |format|
      format.html { render  :inline => response_str }
    end


  end


  #~~~~~~~~~~~~~~~~~~~~~called by AJAX, close the spam news ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # - set special_flag = true & set tag = Closed_spam
  #
  def close_news

    response_str = "NG"

    news_id = Integer(params[:news_id])
    news = News.find(news_id)

    if(news != nil)
      news.special_flag= true

      tag = Tag.find_by_name("Closed_spam") ;
      news.tags =[]
      news.tags << tag
      news.save

      response_str = "OK"
    end

    respond_to do |format|
      format.html { render  :inline => response_str }
    end


  end





  #~~~~~~~~~~~~~~~~~~~~~called by AJAX, close the spam report ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # - set special_flag = true & set tag = Closed_spam
  #
  def close_report

    response_str = "NG"

    news_id = Integer(params[:news_id])
    news = News.find(news_id)

    if(news != nil)
      news.special_flag= true

      news.tags = []
      tag = Tag.find_by_name("Closed_spam_report") ;
      news.tags << tag
      news.save

      response_str = "OK"
    end

    respond_to do |format|
      format.html { render  :inline => response_str }
    end


  end



  #~~~~~~~~~~~~~~~~~~~~~called by AJAX, delete photo then close the spam report ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # - delete the photo
  # - set special_flag = true & set tag = Closed_spam
  #
  def delete_photo_and_close_report

    response_str = "NG"

    spam_id = Integer(params[:spam_id])
    spam = News.find(spam_id)

    report_id = Integer(params[:report_id])
    report = News.find(report_id)

    if(spam != nil && report != nil)
      images = Image.find_by_news_id(spam_id)
      if(images != nil)
        images.delete
        spam.images = []
      end

      report.special_flag= true

      report.tags = []
      tag = Tag.find_by_name("Closed_spam_report") ;
      report.tags << tag
      report.save

      response_str = "OK"
    end

    respond_to do |format|
      format.html { render  :inline => response_str }
    end

  end



end
