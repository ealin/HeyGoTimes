def get_news_from_tw_nownews_focus (m,sleep_period)


nownews_focus_rss_url = [
  #"http://feeds.feedburner.com/nownews/realtime",
  "http://feeds.feedburner.com/inside-blog-taiwan"
] ;


nownews_focus_rss_tag = [
    #"Focus/Special",
    "Internet"
 ] ;




  while true
    link = ""
    command = ""


    for i in (0..(nownews_focus_rss_tag.length - 1))

        feed_url = nownews_focus_rss_url[i]

        command = @host+ 'api/new_news?publish=yes&focus_flag=no&area=Taiwan/&tags='
        command = command + nownews_focus_rss_tag[i] + "&url="


        open(feed_url) {|f|
          f.each_line {|line|
            if line.include?("<feedburner:origLink>")
              temp_str = (line.split("feedburner:origLink>"))[1]
              link =  temp_str[0..temp_str.length-3]
              #p link

              m.synchronize{
                if i==0
                  puts '[NOW-NEWS TW FOCUS]  News Link :' + link
                else
                  puts '[Inside Blog]  News Link :' + link
                end


                open(command + link) {|f|
                   f.each_line {|line| p line}
                 }

                puts "\n"
              }

            end
          }
        }
        sleep(sleep_period)


    end

  end
end

