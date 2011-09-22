def get_news_from_tw_google (m,sleep_period)


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

                    puts '[GOOGLE TW]  News Link :' + link

                    open(command + link) {|f|
                       f.each_line {|line| p line}
                     }

                    puts "\n"
                  }
                end


              end
              sleep(sleep_period)

          rescue OpenURI::HTTPError => the_error
              the_status = the_error.io.status[0] # => 3xx, 4xx, or 5xx
              next
          end
        #}

    end


  end
end

