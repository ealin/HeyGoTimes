def get_news_from_tw_yahoo (m,sleep_period)


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
                    sleep(@sleep_period)
                  end


                end

            rescue OpenURI::HTTPError => the_error
                the_status = the_error.io.status[0] # => 3xx, 4xx, or 5xx
                next
            end
          #}

      end


    end

end
