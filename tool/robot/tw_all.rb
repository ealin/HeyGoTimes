require 'rss/2.0'
require 'open-uri'
require 'net/http'
require 'thread'

# SOP to add new robot:
#    add m.synchronize{
#    add sleep(50)
#

#@host = "http://localhost:3000/"
@host = "http://heygotimes.heroku.com/"

m = Mutex.new

Thread.start{

      ############  TW-Yahoo   ############
      yahoo_rss_url = [
        "http://tw.news.yahoo.com/rss/politics",
        "http://tw.news.yahoo.com/rss/society",
        "http://tw.news.yahoo.com/rss/taiwan",
        "http://tw.news.yahoo.com/rss/intl",
        "http://tw.news.yahoo.com/rss/biz",
        "http://tw.news.yahoo.com/rss/tech",
        "http://tw.news.yahoo.com/rss/sports",
        "http://tw.news.yahoo.com/rss/health",
        "http://tw.news.yahoo.com/rss/edu",
        "http://tw.news.yahoo.com/rss/art",
        "http://tw.news.yahoo.com/rss/showbiz",
        "http://tw.news.yahoo.com/rss/travel",
        "http://tw.news.yahoo.com/rss/life",
        "http://tw.news.yahoo.com/rss/feel_sad",
        "http://tw.news.yahoo.com/rss/feel_bombastic",
        "http://tw.news.yahoo.com/rss/feel_boring",
        "http://tw.news.yahoo.com/rss/feel_useful",
        "http://tw.news.yahoo.com/rss/feel_warm",
        "http://tw.news.yahoo.com/rss/feel_happy",
        "http://tw.news.yahoo.com/rss/feel_angry",
        "http://tw.news.yahoo.com/rss/feel_oddlyenough" ] ;


      yahoo_rss_tag = [
          "Politics",
          "Society",
          "Local",
          "World",
          "Business",
          "Sci_Tech",
          "Sport",
          "Health",
          "Education",
          "Art",
          "Entertainment",
          "Travel",
          "Life",
          "Special", "Special","Special","Special","Special","Special","Special","Special"] ;


    while true

      link = ""
      command = ""

      for i in (0..(yahoo_rss_tag.length - 1))


          feed_url = yahoo_rss_url[i]

          command = @host+ 'api/new_news?publish=yes&area=Taiwan&tags='

          command = command + yahoo_rss_tag[i] + "&url="


            begin
                open(feed_url) do |feed|
                  RSS::Parser.parse(feed.read , false).items.each do |item|
                    m.synchronize{
                      index = (item.link).index("*")
                      link = (item.link)[(index+1)..(item.link).length]

                      puts '[YAHOO TW]News Link :' + link

                      open(command + link) {|f|
                         f.each_line {|line| p line}
                       }

                      puts "\n"
                    }
                    sleep(50)
                  end


                end

            rescue OpenURI::HTTPError => the_error
                the_status = the_error.io.status[0] # => 3xx, 4xx, or 5xx
                next
            end
          #}

      end


    end
}



  ############  TW-Yahoo-beta   ############
=begin
Thread.start{

      yahoo_beta_rss_url = [
          "http://beta.tw.news.yahoo.com/rss/taipei",
          "http://beta.tw.news.yahoo.com/rss/north-taiwan",
          "http://beta.tw.news.yahoo.com/rss/mid-taiwan",
          "http://beta.tw.news.yahoo.com/rss/south-taiwan",
          "http://beta.tw.news.yahoo.com/rss/east-taiwan",
          "http://beta.tw.news.yahoo.com/rss/local/",

        "http://beta.tw.news.yahoo.com/rss/entertainment",
        "http://beta.tw.news.yahoo.com/rss/celebrity",
        "http://beta.tw.news.yahoo.com/rss/music",
        "http://beta.tw.news.yahoo.com/rss/tv-radio",
        "http://beta.tw.news.yahoo.com/rss/movies",
        "http://beta.tw.news.yahoo.com/rss/jp-kr",

        "http://beta.tw.news.yahoo.com/rss/sports",
        "http://beta.tw.news.yahoo.com/rss/basketball",
        "http://beta.tw.news.yahoo.com/rss/baseball",
        "http://beta.tw.news.yahoo.com/rss/golf",
        "http://beta.tw.news.yahoo.com/rss/tennis",
        "http://beta.tw.news.yahoo.com/rss/other-sports",

        "http://beta.tw.news.yahoo.com/rss/politics",

        "http://beta.tw.news.yahoo.com/rss/society",

        "http://beta.tw.news.yahoo.com/rss/world",
        "http://beta.tw.news.yahoo.com/rss/asia-australia",
        "http://beta.tw.news.yahoo.com/rss/china",
        "http://beta.tw.news.yahoo.com/rss/america",
        "http://beta.tw.news.yahoo.com/rss/euro-africa",

        "http://beta.tw.news.yahoo.com/rss/finance",
        "http://beta.tw.news.yahoo.com/rss/stock",
        "http://beta.tw.news.yahoo.com/rss/industry",
        "http://beta.tw.news.yahoo.com/rss/economy",
        "http://beta.tw.news.yahoo.com/rss/real-estate",
        "http://beta.tw.news.yahoo.com/rss/money-career",

        "http://beta.tw.news.yahoo.com/rss/lifestyle",
        "http://beta.tw.news.yahoo.com/rss/weather",
        "http://beta.tw.news.yahoo.com/rss/consumption",
        "http://beta.tw.news.yahoo.com/rss/travel",
        "http://beta.tw.news.yahoo.com/rss/education",
        "http://beta.tw.news.yahoo.com/rss/art",
        "http://beta.tw.news.yahoo.com/rss/lifestyle",

        "http://beta.tw.news.yahoo.com/rss/health",
        "http://beta.tw.news.yahoo.com/rss/disease",
        "http://beta.tw.news.yahoo.com/rss/beauty",

        "http://beta.tw.news.yahoo.com/rss/technology",
        "http://beta.tw.news.yahoo.com/rss/information-3c",
        "http://beta.tw.news.yahoo.com/rss/science" ] ;


      yahoo_beta_rss_tag = [
          "Local","Local","Local","Local","Local","Local",
          "Entertainment","Entertainment","Entertainment","Entertainment","Entertainment","Entertainment",
          "Sport","Sport","Sport","Sport","Sport","Sport",
          "Politics",
          "Society",
          "World","World","World","World","World",
          "Business","Business","Business","Business","Business","Business",
          "Life","Life","Life",
          "Travel",
          "Education",
          "Art",
          "Life",
          "Health","Health","Health",
          "Sci_Tech","Sci_Tech","Sci_Tech"] ;


      yahoo_beta_rss_area = [
          "Taiwan/North_TW/","Taiwan/North_TW/","Taiwan/Middle_TW/","Taiwan/South_TW/","Taiwan/East_TW/","Taiwan/",
          "Taiwan/","Taiwan/","Taiwan/","Taiwan/","Taiwan/","Taiwan/",
          "Taiwan/","Taiwan/","Taiwan/","Taiwan/","Taiwan/","Taiwan/",
          "Taiwan/",
          "Taiwan/",
          "Taiwan/","Taiwan/","Taiwan/","Taiwan/","Taiwan/",
          "Taiwan/","Taiwan/","Taiwan/","Taiwan/","Taiwan/","Taiwan/",
          "Taiwan/","Taiwan/","Taiwan/",
          "Taiwan/",
          "Taiwan/",
          "Taiwan/",
          "Taiwan/",
          "Taiwan/","Taiwan/","Taiwan/",
          "Taiwan/","Taiwan/","Taiwan/"] ;




    while true
      link = ""
      command = ""


      for i in (0..(yahoo_beta_rss_tag.length - 1))


          feed_url = yahoo_beta_rss_url[i]

          command = @host+ 'api/new_news?publish=yes&tags='

          command = command + yahoo_beta_rss_tag[i] + '&area=' + yahoo_beta_rss_area[i] + "&url="

            begin
                open(feed_url) do |feed|
                  RSS::Parser.parse(feed.read , false).items.each do |item|
                    m.synchronize{

                      link = URI.encode(item.link)

                      puts '[YAHOO TW BETA]News Link :' + link

                      open(command + link) {|f|
                         f.each_line {|line| p line}
                       }

                      puts "\n"
                    }
                    sleep(50)
                  end


                end

            rescue OpenURI::HTTPError => the_error
                the_status = the_error.io.status[0] # => 3xx, 4xx, or 5xx
                next
            end
          #}

      end

    end

}
=end


  ############  TW-Google   ############
    google_rss_url = [
      "http://news.google.com.tw/news?pz=1&cf=all&ned=tw&hl=zh-TW&topic=c&output=rss" ,
      "http://news.google.com.tw/news?pz=1&cf=all&ned=tw&hl=zh-TW&topic=w&output=rss",
      "http://news.google.com.tw/news?pz=1&cf=all&ned=tw&hl=zh-TW&topic=n&output=rss" ,
      "http://news.google.com.tw/news?pz=1&cf=all&ned=tw&hl=zh-TW&topic=b&output=rss" ,
      "http://news.google.com.tw/news?pz=1&cf=all&ned=tw&hl=zh-TW&topic=t&output=rss" ,
      "http://news.google.com.tw/news?pz=1&cf=all&ned=tw&hl=zh-TW&topic=s&output=rss" ,
      "http://news.google.com.tw/news?pz=1&cf=all&ned=tw&hl=zh-TW&topic=e&output=rss" ,
      "http://news.google.com.tw/news?pz=1&cf=all&ned=tw&hl=zh-TW&topic=y&output=rss" ,
      "http://news.google.com.tw/news?pz=1&cf=all&ned=tw&hl=zh-TW&topic=m&output=rss" ,
      "http://news.google.com.tw/news?pz=1&cf=all&ned=tw&hl=zh-TW&topic=po&output=rss"

    ] ;


    google_rss_tag = [
        "Local" ,     # todo: area += TW_CH
        "World",
        "Local" ,
        "Business" ,
        "Sci_Tech" ,
        "Sport" ,
        "Entertainment" ,
        "Society" ,
        "Health" ,
        "Special"

        ] ;


while true
    link = ""
    command = ""


    for i in (0..(google_rss_tag.length - 1))

        feed_url = google_rss_url[i]

        if i == 0
          command = @host+ 'api/new_news?publish=no&area=Taiwan/TW_CN/&tags='
        else
          command = @host+ 'api/new_news?publish=no&area=Taiwan/&tags='
        end

        command = command + google_rss_tag[i] + "&url="

          begin
              open(feed_url) do |feed|
                RSS::Parser.parse(feed.read , false).items.each do |item|
                  m.synchronize{

                    link = URI.encode(item.link)

                    puts '[GOOGLE TW]News Link :' + link

                    open(command + link) {|f|
                       f.each_line {|line| p line}
                     }

                    puts "\n"
                  }
                  sleep(50)
                end


              end

          rescue OpenURI::HTTPError => the_error
              the_status = the_error.io.status[0] # => 3xx, 4xx, or 5xx
              next
          end
        #}

    end


end