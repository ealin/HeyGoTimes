class PaperController < NewsController

  def index

    if (params[:type] != nil)
      session[:news_type] = params[:type]
    end

    if (session[:news_type] == nil)
      session[:news_type] = 'latest'
    end

    @news = get_news(session[:news_type], params[:page])

    @tags = Tag.all
    @areas = Area.all

    # for checking login status in View, we must define an obj-attribute @logged_flag and
    #    check_logged_in() in application_controller.rb
    check_logged_in(true)

=begin
    # Ealin: not necessary for new-spec.
    #check_followed()   #一開始就要判斷目前user是否有訂閱這份報紙
    #set_newspaper_size()

    # keep all filters in session
    #
    #session[:filter_tags] = "All"  or "Sport/NBA/"
    #session[:filter_date] ="1971-11-12"   # "1971-11-12" means no filter for date
    #session[:filter_date_option] ="yesterday"   # possible value= "no_limited","today","yesterday","selected_date"
    #session[:filter_friend] = "all"       # possible filters are: "all", "mine", "friend"
    #session[:filter_area]
=end
   init_filter_setting()


   # this function would use data in session, so it must be called after init_filter_setting()
   get_paper_title_info()


  end

  def _show_paper_content
    # params:
    # :type => latest / rank
    # :page => page num to fetch

    session[:news_type] = params[:type]
    @news = get_news(params[:type], params[:page])

    respond_to do |format|
      format.html {render :partial => 'paper/show_paper_content', :locals => {:news => @news}}
    end
  end

  def get_news(type, page)

    @user_areas = []
    if (session[:filter_area] != nil)
      @user_areas = session[:filter_area].split("/")
    else
      # session may be empty (e.g. first time using)
      #
      @user_areas[0] = 'All'
    end

    @user_tags = []
    if (session[:filter_tags] != nil)
      @user_tags = session[:filter_tags].split("/")
    else
      # session may be empty (e.g. first time using)
      #
      @user_tags[0] = 'All'
    end

    if (@user_tags[0] == 'All')
      @news = News.get_all(type)
    else
      if (News.count > 0)
        @news = News.find_by_tags(type, @user_areas, @user_tags)
      end
    end

    if(@news != nil)
      @news = @news.paginate :page => page, :per_page => 3
    end


    return @news
  end

  #-----------------------------------------------------------------------------------
  # method: set_tag_filter_by_locale      (Ealin: 20110607)
  #   - # check the locale (I18n.locale ==? :zh_tw), set area tag if necessary
  #-----------------------------------------------------------------------------------
  def set_tag_filter_by_locale

        if(I18n.locale == :zh_tw)
          session[:filter_area] = "Taiwan/"
        else
          if(I18n.locale == :en)
            session[:filter_area] = "USA/"
          else
            session[:filter_area] = "All"
          end
        end

        session[:filter_tags] = "All"
        session[:filter_date] = "1971-11-12"
        session[:filter_date_option] = "no_limited"
        session[:filter_friend] = "all"

  end

 #-----------------------------------------------------------------------------------
 # method: load_filter_setting_from_db      (Ealin: 20110607)
 #   - load user's saved news-filter setting from DB
 #   (private function for this controller only)
 #-----------------------------------------------------------------------------------
  def load_filter_setting_from_db
        #load filter-setting from db
        user = User.find(session[:id])
        if(user == nil)
          # something wrong!
          set_tag_filter_by_locale
          return
        end

        # get tag filter (from user.tags)
        if(user.tags != [])
          session[:filter_tags] =""
          (user.tags).each do |tag|
            session[:filter_tags] += (tag.name + "/")
          end

          # get area filter from user.areas
          session[:filter_area] =""
          (user.areas).each do |area|
            session[:filter_area] += (area.name + "/")
          end

          # get date filter (from user.date_filter)
          session[:filter_date] = (user.date_filter.date).to_date
          session[:filter_date_option] = user.date_filter.option

          # get friend filter (from user.friend_filter)
          session[:filter_friend] = user.friend_filter.friend_filter_type

        else     # (user.tags == nil)
          set_tag_filter_by_locale
        end
  end

  #-----------------------------------------------------------------------------------
  # method: load_filter_setting      (Ealin: 20110607)
  #   - load user's saved news-filter setting from DB
  #   (public interface for browser)
  #-----------------------------------------------------------------------------------
   def load_filter_setting
     load_filter_setting_from_db

     respond_to do |format|
       format.json { render :json => session.to_json }
     end
   end

 #-----------------------------------------------------------------------------------
 # method: init_filter_setting      (Ealin: 20110607)
 #   - init news-filter setting
 #-----------------------------------------------------------------------------------
  def init_filter_setting

      # 如果SESSION不是空的, 就使用目前SESSION的設定即可 (雖然SESSION裡的內容可能與DB裡的不一樣)
    if( session[:filter_tags] == nil)

      if(session[:logged_in] == true)
        load_filter_setting_from_db
      else   # session is empty
         set_tag_filter_by_locale
      end


    end

  end




  #-----------------------------------------------------------------------------------
  # method: set_newspaper_size      (Ealin: 20110501)
  #   - （設定報紙頁面中, 一些與size有關的attributes）
  #-----------------------------------------------------------------------------------
=begin
  def set_newspaper_size
    @paper_width = 600
    @title_height = 210

    @ad_width = 120
    @ad_height = 60
    @ad_no = 10
  end
=end
  #===========================================================================
 
 
  #-----------------------------------------------------------------------------------
  # method: get_paper_title_info      (Ealin: 20110430)
  #   - （取得 報紙title 裡的資訊 - 報紙名/slogan/date/weather/type...）
  #-----------------------------------------------------------------------------------
  # 
  def get_paper_title_info
    #
    # Ealin: should access database here
    #

    # check filters in session ==> make all filters as news-title
    #
    counter = 0
    @newspaper_title = "您的專屬新聞 - "
    @tags.each do |tag|
      if session[:filter_tags].include?(tag.name)
        @newspaper_title += (t(tag.name.to_sym) + " ")
        counter += 1
        if counter >= 5
          @newspaper_title += "..."
          break
        end
      end
    end


    #@newspaper_slogan = t :sample_paper_slogan
    #@weather = :Thunderstorms  # need to define
    #@layout_style = :normal    # need to define

    temp_time = Time.new
    @date = temp_time.inspect

  end

  #===========================================================================


  #-----------------------------------------------------------------------------------
  # method: get_paper_title_info      (Ealin: 20110430)
  #   - （取得 報紙title 裡的資訊 - 報紙名/slogan/date/weather/type...）
  #-----------------------------------------------------------------------------------
  # 
  def show_paper_title
    #get newspaper's title
    get_paper_title_info()
   
    # render _show_paper_title.html.erb
    render :layout => nil
    
    
  end

  #===========================================================================



  #-----------------------------------------------------------------------------------
  # method: show_paper_content      (Ealin: 20110501)
  #   - 顯示本日報紙的內容
  #-----------------------------------------------------------------------------------
  # 
  def show_paper_content

     # render _show_paper_content.html.erb
     render :layout => nil
   
  end

  #===========================================================================



  #-----------------------------------------------------------------------------------
  # method: show_ad_list      (Ealin: 20110501)
  #   - 顯示本日報紙的內容
  #-----------------------------------------------------------------------------------
  # 
  def show_ad_list

     # render _show_ad_list.html.erb
     render :layout => nil
   
  end

  #===========================================================================


  #-----------------------------------------------------------------------------------
  # method: show_fun_buttons      (Ealin: 20110501)
  #   - （Show functional buttons : 1.Report_a_news/2.Edit_realtimes_news/3.my_AD
  #-----------------------------------------------------------------------------------
  # 
  def show_fun_buttons
   
   
    # render _show_paper_title.html.erb
    render :layout => nil
    
  end

  #===========================================================================


  #---------------------------------------------------------
  # method: check_followed
  #   - 目前的user是否有訂閱這份報紙？  (Ealin: 20110430)
  #---------------------------------------------------------
  #
=begin
  def check_followed
    # 目前的user是否有訂閱這份報紙？
    @followed_flag = false

    return @followed_flag
  end
=end
  #===========================================================================



  # Ealin: 20110430
  #-----------------------------------------
  # method: follow
  #   - 訂閱 或 取消訂閱 這份報紙
  #-----------------------------------------
  #
=begin
  def follow 

    if params[:flag] == "true"
      if @followed_flag == false
        #logger.degug "新增訂戶"
        @followed_flag = true
      end
    else   
     if @followed_flag == true
        #logger.degug "取消訂戶"
        @followed_flag = false
      end      
    end    

  end
=end
  #-----------------------------------------




  # Ealin: 20110411
  #--------------------------
  # method: to_main_page
  #--------------------------
  #
=begin
 def to_main_page
    
    # link to "main_page/index" 
    #
    redirect_to  :controller => 'main_page', :action => 'index'
 end
=end
  #-----------------------------------------


  # Ealin: 20110426
  #----------------------------------------
  # method: filiter_today_newspaper  過濾新聞
  #----------------------------------------
  #
=begin
  def filiter_today_newspaper
    
    logger.debug '[logging] filiter_papers executed'

  end
=end
  #-----------------------------------------


  # Ealin: 20110604
  #-------------------------------------------------------------------------------------
  # method: set_filter_setting
  #  - this method would be called by ajax in paper/_show)news_filter.html.erb
  #-------------------------------------------------------------------------------------
  #
  def set_filter_setting
    session[:filter_tags] = params[:tag_filter]
    session[:filter_area] = params[:area_filter]

    if(params[:friend_filter] == "")
      session[:filter_friend] = "all"
    else
      session[:filter_friend] = params[:friend_filter]
    end

    session[:filter_date] = params[:date_filter]
    session[:filter_date_option] = params[:date_filter_option]

    response_str = t(:filter_setting_saved)
    if(params[:save] == "yes")
      # save the filter setting in DB

      user = User.find(session[:id])
      if(user == nil)
        response_str = t(:user_not_exist)
      end

      # setup user.tags
      #
      user.tags = []       #empty array
      tags = Tag.all
      tags.each do |tag|
        if (session[:filter_tags]).include?(tag.name)
          user.tags << tag  # many-to-many relationship ==> it would be saved to DB automatically
        end
      end

      # setup user.areas
      #
      user.areas = []       #empty array
      areas = Area.all
      areas.each do |area|
        if (session[:filter_area]).include?(area.name)
          user.areas << area  # many-to-many relationship ==> it would be saved to DB automatically
        end
      end

      # setup user.date_filter
      #
      temp_date_filter = DateFilter.new(:date => session[:filter_date], :option => session[:filter_date_option])
      temp_date_filter.save
      user.date_filter = temp_date_filter


      #setup user.friend_filters
      temp_friend_filter = FriendFilter.new()
      temp_friend_filter.friend_filter_type = session[:filter_friend]
      temp_friend_filter.save
      user.friend_filter = temp_friend_filter


    end

    #logger.debug "[logging]Filter setting saved in session!"

    # IMPORTANT: it must response something to browser, or the session would not be saved to local cookie!!!
    #
    respond_to do |format|
      format.html { render  :inline => response_str }
      #format.html { render  :partial => "paper/ack" }
    end


    # redraw the paper page  <=== caller (JS code in _show_news_filter.html.erb would do this job!)

  end




  # Ealin: 20110604
  #-------------------------------------------------------------------------------------
  # method: get_filter_session
  #  - seed back all session to filter-dialog
  #-------------------------------------------------------------------------------------
  #
  def get_filter_session


    respond_to do |format|
      format.json { render :json => session.to_json }
    end

  end

end
