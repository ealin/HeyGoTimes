class PaperController < NewsController

  def index

    if (params[:type] != nil)
      session[:news_type] = params[:type]
    end

    if (session[:news_type] == 'undefined')
      session[:news_type] = 'rank'
    end

    @news = get_news(session[:news_type], params[:page])
    session[:news_load_time] = Time.now

    @tags = Tag.all
    @areas = Area.all

    # for checking login status in View, we must define an obj-attribute @logged_flag and
    #    check_logged_in() in application_controller.rb
    check_logged_in(true)

    init_filter_setting()


    # this function would use data in session, so it must be called after init_filter_setting()
    get_paper_title_info()

  end



  def _show_paper_content
    # params:
    # :type => latest / rank / special
    # :page => page num to fetch
    # :news_num => load ? news
    @loading_news_num = params[:news_num] ;

    if @loading_news_num == nil
      @loading_news_num = 10
    end

    if (params[:type] == 'special')
      @news = get_special_news(params[:sub_type], params[:page])
    else
      session[:news_type] = params[:type]
      @news = get_news(params[:type], params[:page])
    end

    respond_to do |format|
      format.html {render :partial => 'paper/show_paper_content',
                    :locals => {:news => @news, :news_sub_type => params[:sub_type]}}
    end
  end



  def get_news(type, page)
    if @loading_news_num == nil
      @loading_news_num = 10
    end

    user_areas = []
    if (session[:filter_area] != nil && session[:filter_area] != "")
      user_areas = session[:filter_area].split("/")
    else
      # session may be empty (e.g. first time using)
      #
      user_areas[0] = 'All_area'
    end

    user_tags = []
    if (session[:filter_tags] != nil)
      user_tags = session[:filter_tags].split("/")
    else
      # session may be empty (e.g. first time using)
      #
      user_tags[0] = 'All'
    end

    if (session[:id] != nil)
      user_id = session[:id]
      if (session[:filter_friend] != nil)
        friend_tags = session[:filter_friend].split("/")
        if (friend_tags[0] == 'all')
          friend_type = :none
        elsif (friend_tags[0] == 'mine' && friend_tags[1] == 'friend')
          friend_type = :both
        elsif (friend_tags[0] == 'friend')
          friend_type = :friend
        else
          friend_type = :mine
        end
      else
        # session may be empty (e.g. first time using)
        #
        friend_type = :none
      end
    else
      user_id = nil
      friend_type = :none
    end

    if (News.count > 0)
      if (user_tags[0] == 'All') && (user_areas[0] == 'All_area')

          @news = News.get_all(type, friend_type, user_id).paginate :page => page, :per_page => @loading_news_num
      else
        @news = News.find_by_tags(type, friend_type, user_id, user_areas, user_tags).paginate :page => page, :per_page => @loading_news_num
      end

        
      if (page != 1 && session[:news_load_time] != nil)
        @news.each_with_index do |news, index|
          if (news.created_at > session[:news_load_time])
            @news.delete_at(index)
          else
            break
          end
        end
      end

    end

    return @news

  end


  def get_special_news(type, page)
    if @loading_news_num == nil
      @loading_news_num = 10
    end


    if (type == 'notice')
      tags = ["HGTimesNotice"]
      areas = ["Taiwan"]
      friend_type = :none
      user_id = nil
    elsif (type == 'faq')
      tags = ["FAQ"]
      areas = ["Taiwan"]
      friend_type = :none
      user_id = nil
    elsif (type == 'feedback')
      tags = ["FeedbackTag","Closed_spam_report"]
      areas = ["Taiwan","All_area"]
      friend_type = :mine
      user_id = session[:id]
    end

    news = News.get_all_special(areas, tags, friend_type, user_id)

    if(news.count > 0)
      news = news.paginate :page => page, :per_page => @loading_news_num
    end

    return news
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
            session[:filter_area] = "All_area"
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
    @newspaper_title = t(:slogan)
    @areas.each do |area|
      if session[:filter_area].include?(area.name)
        @newspaper_title += (t(area.name.to_sym) + " ")
      end
    end


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

    render :layout => nil
    
  end

  #===========================================================================


  # Ealin: 20110604
  #-------------------------------------------------------------------------------------
  # method: set_filter_setting
  #  - this method would be called by ajax in paper/_show)news_filter.html.erb
  #-------------------------------------------------------------------------------------
  #
  def set_filter_setting
    session[:filter_tags] = params[:tag_filter]
    session[:filter_area] = params[:area_filter] if (params[:area_filter] != nil)

    if(params[:friend_filter] == "")
      session[:filter_friend] = "all"
    else
      session[:filter_friend] = params[:friend_filter]
    end

    session[:filter_date] = params[:date_filter] if (params[:date_filter] != nil)
    session[:filter_date_option] = params[:date_filter_option] if (params[:date_filter_option] != nil)

    response_str = t(:filter_setting_saved)


    if(params[:save] == "yes" && session[:logged_in] != false)
      # save the filter setting in DB

      # if selected area is a sub-area, tag "Local" should be selected also!
      sub_area_flag = false


      user = User.find(session[:id])
      if(user == nil)
        response_str = t(:user_not_exist)
      else

        # setup user.areas
        #
        user.areas = []       #empty array
        areas = Area.all
        areas.each do |area|
          if (session[:filter_area]).include?(area.name)
            if area.parent_area != nil && area.parent_area != ''
              sub_area_flag = true
            end

            user.areas << area  # many-to-many relationship ==> it would be saved to DB automatically
          end
        end

        # setup user.tags
        #
        user.tags = []       #empty array
        tags = Tag.all
        tags.each do |tag|

          if sub_area_flag == true && tag.name == 'Local'
            user.tags << tag
            session[:filter_tags] += "Local/"
            next
          end

          if (session[:filter_tags]).include?(tag.name)
            user.tags << tag  # many-to-many relationship ==> it would be saved to DB automatically
            if(tag.name == 'All')
              session[:filter_tags] = 'All'
              break
            end
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

        user.save
       end
    end

    redirect_to root_url

    #logger.debug "[logging]Filter setting saved in session!"

    # IMPORTANT: it must response something to browser, or the session would not be saved to local cookie!!!
    #
    #respond_to do |format|
    #  format.html { render  :inline => response_str }
    #end


    # redraw the paper page  <=== caller (JS code in _show_news_filter.html.erb would do this job!)

  end




  # Ealin: 20110604
  #-------------------------------------------------------------------------------------
  # method: get_filter_session
  #  - seed back all session to filter-dialog
  #-------------------------------------------------------------------------------------
  #
=begin
  def get_filter_session

    # friend filter could not work if the user is not logged in.
    #
    if(session[:logged_in] == false)
      session[:filter_friend] = "all"
    end

    respond_to do |format|
      format.json { render :json => session.to_json }
    end

  end
=end

end

