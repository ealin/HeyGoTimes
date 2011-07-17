def get_news_from_tw_apple_focus (m,sleep_period)


      apple_rss_url = [
        "http://tw.nextmedia.dynamic.feedsportal.com/pf/589007/tw.nextmedia.com/rss/newcreate/kind/rnews/type/101",
      "http://tw.nextmedia.dynamic.feedsportal.com/pf/589007/tw.nextmedia.com/rss/newcreate/kind/rnews/type/103",
      "http://tw.nextmedia.dynamic.feedsportal.com/pf/589007/tw.nextmedia.com/rss/newcreate/kind/rnews/type/105",
      "http://tw.nextmedia.dynamic.feedsportal.com/pf/589007/tw.nextmedia.com/rss/newcreate/kind/rnews/type/107",
      "http://tw.nextmedia.dynamic.feedsportal.com/pf/589007/tw.nextmedia.com/rss/newcreate/kind/rnews/type/102",
      "http://tw.nextmedia.dynamic.feedsportal.com/pf/589007/tw.nextmedia.com/rss/newcreate/kind/rnews/type/104",
      "http://tw.nextmedia.dynamic.feedsportal.com/pf/589007/tw.nextmedia.com/rss/newcreate/kind/rnews/type/106"] ;


      apple_rss_tag = [
          "Politics",
          "World",
          "Life",
          "Sport",
          "Society",
          "Business",
          "Entertainment"] ;



    while true

      link = ""
      command = ""

      for i in (0..(apple_rss_tag.length - 1))


          feed_url = apple_rss_url[i]

          command = @host+ 'api/new_news?publish=yes&area=Taiwan&tags='

          command = command + apple_rss_tag[i]

          command = command + "&focus_flag=yes"

          command = command + "&url="


            begin
                open(feed_url) do |feed|
                  RSS::Parser.parse(feed.read , false).items.each do |item|
                    m.synchronize{

                      link = URI.encode(item.link)

                      puts '[APPLE TW FOCUS]News Link :' + link

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
