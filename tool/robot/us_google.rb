def get_news_from_us_google (m,sleep_period)


google_rss_url = [
  "http://news.google.com.tw/news?jfkl=true&cf=all&ned=us&hl=en&output=rss" ,
  "http://news.google.com.tw/news?jfkl=true&cf=all&ned=us&hl=en&topic=ir&output=rss",
  "http://news.google.com.tw/news?jfkl=true&cf=all&ned=us&hl=en&topic=w&output=rss",
  "http://news.google.com.tw/news?jfkl=true&cf=all&ned=us&hl=en&topic=n&output=rss",
  "http://news.google.com.tw/news?jfkl=true&cf=all&ned=us&hl=en&topic=b&output=rss",
  "http://news.google.com.tw/news?jfkl=true&cf=all&ned=us&hl=en&topic=tc&output=rss",
  "http://news.google.com.tw/news?jfkl=true&cf=all&ned=us&hl=en&topic=e&output=rss",
  "http://news.google.com.tw/news?jfkl=true&cf=all&ned=us&hl=en&topic=s&output=rss",
  "http://news.google.com.tw/news?jfkl=true&cf=all&ned=us&hl=en&topic=snc&output=rss",
  "http://news.google.com.tw/news?jfkl=true&cf=all&ned=us&hl=en&topic=m&output=rss",

] ;


google_rss_tag = [
    "Focus" ,
    "Focus",
    "World" ,
    "Local",
    "Business",
    "Sci_Tech",
    "Entertainment",
    "Sport",
    "Sci_Tech",
    "Health",

    ] ;




  while true
    link = ""
    command = ""


    for i in (0..(google_rss_tag.length - 1))

        feed_url = google_rss_url[i]

        if i <= 1
          command = @host+ 'api/new_news?publish=yes&focus_flag=yes&area=USA/&tags='
        else
          command = @host+ 'api/new_news?publish=yes&area=USA/&tags='
        end


        command = command + google_rss_tag[i] + "&url="

          begin
              open(feed_url) do |feed|
                RSS::Parser.parse(feed.read , false).items.each do |item|
                  m.synchronize{

                    link = URI.encode(item.link)

                    puts '[GOOGLE USA]  News Link :' + link

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

