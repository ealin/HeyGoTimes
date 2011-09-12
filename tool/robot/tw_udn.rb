def get_news_from_tw_udn (m,sleep_period)


udn_rss_url = [
  "http://udn.com/udnrss/politics.xml",
  "http://udn.com/udnrss/social.xml",
  "http://udn.com/udnrss/life.xml",
  "http://udn.com/udnrss/mainland.xml",
  "http://udn.com/udnrss/international.xml",
  "http://mag.udn.com/udnrss/world_rss.xml",
  "http://udn.com/udnrss/financechina.xml",
  "http://udn.com/udnrss/financeworld.xml",
  "http://mag.udn.com/udnrss/newsstand_tm_rss.xml",
  "http://mag.udn.com/udnrss/newsstand_lc_rss.xml",
  "http://udn.com/udnrss/financesfocus.xml",
  "http://udn.com/udnrss/stock.xml",
  "http://mag.udn.com/udnrss/report_rss.xml",
  "http://mag.udn.com/udnrss/newsstand_ms_rss.xml",
  "http://mag.udn.com/udnrss/newsstand_fm_rss.xml",
  "http://udn.com/udnrss/tax.xml",
  "http://udn.com/udnrss/houses.xml",
  "http://mag.udn.com/udnrss/wealth_rss.xml",
  "http://mag.udn.com/udnrss/fund_rss.xml",
  "http://mag.udn.com/udnrss/m_forum_rss.xml",
  "http://udn.com/udnrss/baseball.xml",
  "http://mag.udn.com/udnrss/sports_rss.xml",
  "http://mag.udn.com/udnrss/newsstand_st_rss.xml",
  "http://udn.com/udnrss/basketball.xml",
  "http://udn.com/udnrss/sportsfocus.xml",
  "http://udn.com/udnrss/starsfocus.xml",
  "http://udn.com/udnrss/starswestern.xml",
  "http://udn.com/udnrss/movie.xml",
  "http://udn.com/udnrss/tv.xml",
  "http://udn.com/udnrss/starsjk.xml",
  "http://udn.com/udnrss/music.xml",
  "http://mag.udn.com/udnrss/digital_rss.xml",
  "http://mag.udn.com/udnrss/happylife_rss.xml",
  "http://udn.com/udnrss/food.xml",
  "http://udn.com/udnrss/shopping.xml",
  "http://mag.udn.com/udnrss/car_rss.xml",
  "http://udn.com/udnrss/health.xml",
  "http://travel.udn.com/udnrss/travel_rss.xml",
  "http://mag.udn.com/udnrss/life_rss.xml",
  "http://mag.udn.com/udnrss/newsstand_lh_rss.xml",
  "http://udn.com/udnrss/local_taipei.xml",
  "http://udn.com/udnrss/local_tcchnt.xml",
  "http://udn.com/udnrss/local_ksptisland.xml",
  "http://udn.com/udnrss/local_tyhcml.xml",
  "http://udn.com/udnrss/local_ylcytn.xml",
  "http://udn.com/udnrss/local_klilhltt.xml",
  "http://udn.com/udnrss/local_oddlyenough.xml",
  "http://mag.udn.com/udnrss/people_rss.xml",
  "http://udn.com/udnrss/focus.xml",
  "http://udn.com/udnrss/BREAKINGNEWS1.xml",
  "http://udn.com/udnrss/BREAKINGNEWS4.xml",
  "http://udn.com/udnrss/BREAKINGNEWS6.xml",
  "http://udn.com/udnrss/latest.xml",
  "http://udn.com/udnrss/udpopular.xml",
  "http://udn.com/udnrss/unpopular.xml",
  "http://udn.com/udnrss/mostpopular.xml",
  "http://udn.com/udnrss/endpopular.xml",
  "http://video.udn.com/rss/video_rss.xml"

] ;


udn_focus_rss_tag = [
    "Politics&area=Taiwan/",
    "Society&area=Taiwan/",
    "Life/Local&area=Taiwan/",
    "World&area=Taiwan/TW_CN/",
    "World&area=Taiwan/",
    "World&area=Taiwan/",
    "World/Business&area=Taiwan/TW_CN/",
    "World/Business&area=Taiwan/",
    "Sci_Tech&area=Taiwan/",
    "Local&area=Taiwan/",
    "Business&area=Taiwan/",
    "Business&area=Taiwan/",
    "Business&area=Taiwan/",
    "Business&area=Taiwan/",
    "Business&area=Taiwan/",
    "Business&area=Taiwan/",
    "Business&area=Taiwan/",
    "Business&area=Taiwan/",
    "Business&area=Taiwan/",
    "Business&area=Taiwan/",
    "Sport&area=Taiwan/",
    "Sport&area=Taiwan/",
    "Sport&area=Taiwan/",
    "Sport&area=Taiwan/",
    "Sport&area=Taiwan/",
    "Entertainment&area=Taiwan/",
    "Entertainment&area=Taiwan/",
    "Entertainment&area=Taiwan/",
    "Entertainment&area=Taiwan/",
    "Entertainment&area=Taiwan/",
    "Entertainment&area=Taiwan/",
    "Sci_Tech/Business&area=Taiwan/",
    "Life&area=Taiwan/",
    "Life&area=Taiwan/",
    "Life&area=Taiwan/",
    "Life&area=Taiwan/",

    #"Health/Life&area=Taiwan/",
    #"Travel/Life&area=Taiwan/",
    #"Health/Life&area=Taiwan/",
    #"Health/Life&area=Taiwan/",
    "Life/Special&area=Taiwan/",
    "Life/Special&area=Taiwan/",
    "Life/Special&area=Taiwan/",
    "Life/Special&area=Taiwan/",


    "Local&area=Taiwan/North_TW/",
    "Local&area=Taiwan/Middle_TW/",
    "Local&area=Taiwan/South_TW/",
    "Local&area=Taiwan/North_TW/",
    "Local&area=Taiwan/South_TW/",
    "Local&area=Taiwan/East_TW/",
    "Local&area=Taiwan/",
    "Local&area=Taiwan/",
    "Focus&area=Taiwan/",
    "Focus/Politics&area=Taiwan/",
    "Focus/World&area=Taiwan/TW_CN",
    "Focus/Business&area=Taiwan/",
    "Focus&area=Taiwan/",
    "Focus&area=Taiwan/",
    "Focus&area=Taiwan/",
    "Focus&area=Taiwan/",
    "Focus&area=Taiwan/",
    "Focus/Motion&area=Taiwan/",
 ] ;



  while true
    link = ""
    command = ""


    for i in (0..(udn_focus_rss_tag.length - 1))

        feed_url = udn_rss_url[i]

        command = @host+ 'api/new_news?publish=yes&no_photo=yes&focus_flag=yes&tags='
        command = command + udn_focus_rss_tag[i] + "&url="


        begin
             open(feed_url) do |feed|
               RSS::Parser.parse(feed.read , false).items.reverse.each do |item|

                 m.synchronize{

                   link = URI.encode(item.link)

                   puts '[UDN TW]  News Link :' + link

                   open(command + link) {|f|
                      f.each_line {|line| p line}
                    }

                   puts "\n"
                 }
               end


             end

             sleep(@sleep_period)


         rescue OpenURI::HTTPError => the_error
             the_status = the_error.io.status[0] # => 3xx, 4xx, or 5xx
             next
         end

   end


  end
end

