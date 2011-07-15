require 'rss/2.0'
require 'open-uri'
require 'net/http'

@host = "http://localhost:3000/"
#@host = "http://heygotimes.heroku.com/"



    google_rss_url = [
      "http://news.google.com.tw/news?pz=1&cf=all&ned=tw&hl=zh-TW&topic=w&output=rss",
      "http://news.google.com.tw/news?pz=1&cf=all&ned=tw&hl=zh-TW&topic=n&output=rss" ,
      "http://news.google.com.tw/news?pz=1&cf=all&ned=tw&hl=zh-TW&topic=b&output=rss" ,
      "http://news.google.com.tw/news?pz=1&cf=all&ned=tw&hl=zh-TW&topic=t&output=rss" ,
      "http://news.google.com.tw/news?pz=1&cf=all&ned=tw&hl=zh-TW&topic=s&output=rss" ,
      "http://news.google.com.tw/news?pz=1&cf=all&ned=tw&hl=zh-TW&topic=e&output=rss" ,
      "http://news.google.com.tw/news?pz=1&cf=all&ned=tw&hl=zh-TW&topic=c&output=rss" ,
      "http://news.google.com.tw/news?pz=1&cf=all&ned=tw&hl=zh-TW&topic=y&output=rss" ,
      "http://news.google.com.tw/news?pz=1&cf=all&ned=tw&hl=zh-TW&topic=m&output=rss" ,
      "http://news.google.com.tw/news?pz=1&cf=all&ned=tw&hl=zh-TW&topic=po&output=rss"

    ] ;


    google_rss_tag = [
        "World",
        "Local" ,
        "Business" ,
        "Sci_Tech" ,
        "Sport" ,
        "Entertainment" ,
        "Local" ,     # todo: area += TW_CH
        "Society" ,
        "Health" ,
        "Special"

        ] ;


    link = ""
    command = ""

while true

    for i in (0..(google_rss_tag.length - 1))


        feed_url = google_rss_url[i]

        command = @host+ 'api/new_news?publish=no&area=Taiwan/&tags='

        command = command + google_rss_tag[i] + "&url="

        begin
            open(feed_url) do |feed|
              RSS::Parser.parse(feed.read , false).items.each do |item|

                link = URI.encode(item.link)

                puts 'News Link :' + link

                open(command + link) {|f|
                   f.each_line {|line| p line}
                 }

                puts "\n"
              end


            end

        rescue OpenURI::HTTPError => the_error
            the_status = the_error.io.status[0] # => 3xx, 4xx, or 5xx
            next
        end

    end

    puts "sleeping awhile"
    sleep 300   # seconds



end
