def get_news_from_tw_nownews (m,sleep_period)


nownews_rss_url = [
  "http://feeds.feedburner.com/nownews/politic",
  "http://feeds.feedburner.com/nownews/finance",
  "http://feeds.feedburner.com/nownews/social",
  "http://feeds.feedburner.com/nownews/life",
  "http://feeds.feedburner.com/nownews/travel",
  "http://feeds.feedburner.com/nownews/it",
  "http://feeds.feedburner.com/nownews/novelty",
  "http://feeds.feedburner.com/nownews/cybersex",
  "http://feeds.feedburner.com/nownews/entertainment",
  "http://feeds.feedburner.com/nownews/sports"

] ;


nownews_rss_tag = [
    "Politics",
    "Business",
    "Society",
    "Life",
    "Travel",
    "Sci_Tech",
    "Special",
    "Special",
    "Entertainment",
    "Sport"
 ] ;




  while true
    link = ""
    command = ""


    for i in (0..(nownews_rss_tag.length - 1))

        feed_url = nownews_rss_url[i]

        command = @host+ 'api/new_news?publish=yes&focus_flag=no&area=Taiwan/&tags='
        command = command + nownews_rss_tag[i] + "&url="


        open(feed_url) {|f|
          f.each_line {|line|
            if line.include?("<feedburner:origLink>")
              temp_str = (line.split("feedburner:origLink>"))[1]
              link =  temp_str[0..temp_str.length-3]
              #p link

              begin
                m.synchronize{
                  puts '[NOW-NEWS TW]  News Link :' + link
                    open(command + link) {|f|
                       f.each_line {|line| p line}
                     }
                  puts "\n"
                }
              rescue OpenURI::HTTPError => the_error
                  the_status = the_error.io.status[0] # => 3xx, 4xx, or 5xx
                  next
              end

            end
          }
        }

    end
    sleep(sleep_period)


  end
end

