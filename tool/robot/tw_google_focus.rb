def get_news_from_tw_google_focus (m,sleep_period)


google_focus_rss_url = [
  "http://news.google.com.tw/news?pz=1&cf=all&ned=tw&hl=zh-TW&topic=m&output=rss"
] ;


google_focus_rss_tag = [
    "Focus"
 ] ;




  while true
    link = ""
    command = ""


    for i in (0..(google_focus_rss_tag.length - 1))

        feed_url = google_focus_rss_url[i]

        command = @host+ 'api/new_news?publish=no&&focus_flag=yes&area=Taiwan/&tags='

        command = command + google_focus_rss_tag[i] + "&url="

          begin
              open(feed_url) do |feed|
                RSS::Parser.parse(feed.read , false).items.each do |item|
                  m.synchronize{

                    link = URI.encode(item.link)

                    puts '[GOOGLE TW FOCUS]News Link :' + link

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

