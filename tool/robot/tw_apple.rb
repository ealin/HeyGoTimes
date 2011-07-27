def get_news_from_tw_apple (m,sleep_period)


      apple_rss_url = [
        "http://tw.nextmedia.dynamic.feedsportal.com/pf/589008/tw.nextmedia.com/rss/newcreate/kind/sec/type/13",
        "http://tw.nextmedia.dynamic.feedsportal.com/pf/588338/tw.nextmedia.com/rss/newcreate/kind/sec/type/11",
        "http://tw.nextmedia.dynamic.feedsportal.com/pf/588338/tw.nextmedia.com/rss/newcreate/kind/sec/type/151",
        "http://tw.nextmedia.dynamic.feedsportal.com/pf/588338/tw.nextmedia.com/rss/newcreate/kind/sec/type/2724",
        "http://tw.nextmedia.dynamic.feedsportal.com/pf/588338/tw.nextmedia.com/rss/newcreate/kind/sec/type/1076",
        "http://tw.nextmedia.dynamic.feedsportal.com/pf/588338/tw.nextmedia.com/rss/newcreate/kind/sec/type/1066",
        "http://tw.nextmedia.dynamic.feedsportal.com/pf/588338/tw.nextmedia.com/rss/newcreate/kind/sec/type/9499",
        "http://tw.nextmedia.dynamic.feedsportal.com/pf/589008/tw.nextmedia.com/rss/newcreate/kind/sec/type/31488833",
        "http://tw.nextmedia.dynamic.feedsportal.com/pf/589008/tw.nextmedia.com/rss/newcreate/kind/sec/type/1697",
        "http://tw.nextmedia.dynamic.feedsportal.com/pf/589009/tw.nextmedia.com/rss/newcreate/kind/sec/type/14",
        "http://tw.nextmedia.dynamic.feedsportal.com/pf/589009/tw.nextmedia.com/rss/newcreate/kind/sec/type/1052",
        "http://tw.nextmedia.dynamic.feedsportal.com/pf/589009/tw.nextmedia.com/rss/newcreate/kind/sec/type/1028",
        "http://tw.nextmedia.dynamic.feedsportal.com/pf/589009/tw.nextmedia.com/rss/newcreate/kind/sec/type/1048",
        "http://tw.nextmedia.dynamic.feedsportal.com/pf/589009/tw.nextmedia.com/rss/newcreate/kind/sec/type/1078",
        "http://tw.nextmedia.dynamic.feedsportal.com/pf/589009/tw.nextmedia.com/rss/newcreate/kind/sec/type/3847",
        "http://tw.nextmedia.dynamic.feedsportal.com/pf/589011/tw.nextmedia.com/rss/newcreate/kind/sec/type/1600",
        "http://tw.nextmedia.dynamic.feedsportal.com/pf/589011/tw.nextmedia.com/rss/newcreate/kind/sec/type/26153",
        "http://tw.nextmedia.dynamic.feedsportal.com/pf/589011/tw.nextmedia.com/rss/newcreate/kind/sec/type/2890",
        "http://tw.nextmedia.dynamic.feedsportal.com/pf/589011/tw.nextmedia.com/rss/newcreate/kind/sec/type/6270",
        "http://tw.nextmedia.dynamic.feedsportal.com/pf/589012/tw.nextmedia.com/rss/newcreate/kind/sec/type/2153",
        "http://tw.nextmedia.dynamic.feedsportal.com/pf/589012/tw.nextmedia.com/rss/newcreate/kind/sec/type/16289",
        "http://tw.nextmedia.dynamic.feedsportal.com/pf/589012/tw.nextmedia.com/rss/newcreate/kind/sec/type/16",
        "http://tw.nextmedia.dynamic.feedsportal.com/pf/589012/tw.nextmedia.com/rss/newcreate/kind/sec/type/2154",
        "http://tw.nextmedia.dynamic.feedsportal.com/pf/589014/tw.nextmedia.com/rss/newcreate/kind/sec/type/17",
        "http://tw.nextmedia.dynamic.feedsportal.com/pf/589014/tw.nextmedia.com/rss/newcreate/kind/sec/type/18",
        "http://tw.nextmedia.dynamic.feedsportal.com/pf/589014/tw.nextmedia.com/rss/newcreate/kind/sec/type/19",
        "http://tw.nextmedia.dynamic.feedsportal.com/pf/589014/tw.nextmedia.com/rss/newcreate/kind/sec/type/ALL24"
] ;


      apple_rss_tag = [
          "Local&area=Taiwan/TW_CN",
          "Focus&area=Taiwan",
          "Politics&area=Taiwan",
          "Life&area=Taiwan",
          "Local&area=Taiwan",
          "Society&area=Taiwan",
          "Society&area=Taiwan",
          "World&area=Taiwan",
          "World&area=Taiwan",
          "Business&area=Taiwan",
          "Business&area=Taiwan",
          "Business&area=Taiwan",
          "Business&area=Taiwan",
          "Business&area=Taiwan",
          "Business&area=Taiwan",
          "Entertainment&area=Taiwan",
          "Entertainment&area=Taiwan",
          "Entertainment&area=Taiwan",
          "Entertainment&area=Taiwan",
          "Sport&area=Taiwan",
          "Sport&area=Taiwan",
          "Sport&area=Taiwan",
          "Sport&area=Taiwan",
          "Life&area=Taiwan",
          "Sci_Tech&area=Taiwan",
          "Health&area=Taiwan",
          "Travel&area=Taiwan"
            ] ;



    while true

      link = ""
      command = ""

      for i in (0..(apple_rss_tag.length - 1))


          feed_url = apple_rss_url[i]

          command = @host+ 'api/new_news?publish=yes&tags='

          command = command + apple_rss_tag[i]

          command = command + "&url="


            begin
                open(feed_url) do |feed|
                  RSS::Parser.parse(feed.read , false).items.each do |item|
                    m.synchronize{

                      link = URI.encode(item.link)

                      puts '[APPLE TW]  News Link :' + link

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
