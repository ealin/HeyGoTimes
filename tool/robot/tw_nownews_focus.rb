def get_news_from_tw_nownews_focus (m,sleep_period)


nownews_focus_rss_url = [
  "http://feeds.feedburner.com/nownews/realtime"
] ;


nownews_focus_rss_tag = [
    "Focus"
 ] ;




  while true
    link = ""
    command = ""


    for i in (0..(nownews_focus_rss_tag.length - 1))

        feed_url = nownews_focus_rss_url[i]

        command = @host+ 'api/new_news?publish=no&focus_flag=yes&area=Taiwan/&tags='

        command = command + nownews_focus_rss_tag[i] + "&url="

          begin
              open(feed_url) do |feed|
                RSS::Parser.parse(feed.read , false).items.each do |item|
                  m.synchronize{

                    link = URI.encode(item.link)

                    puts '[NOW-NEWS TW FOCUS]News Link :' + link

                    open(command + link) {|f|
                       f.each_line {|line| p line}
                     }

                    puts "\n"
                  }
                  sleep(sleep_period)
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

