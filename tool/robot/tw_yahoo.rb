require 'rss/2.0'
require 'open-uri'
require 'net/http'

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


    link = ""
    command = ""

while true

    for i in (0..(yahoo_rss_tag.length - 1))


        feed_url = yahoo_rss_url[i]

        command = 'http://localhost:3000/api/new_news?area=Taiwan&tags='
        #command = 'http://heygotimes-bench.heroku.com/api/new_news?area=Taiwan&tags='
        #command = 'http://heygotimes.heroku.com/api/new_news?area=Taiwan&tags='

        command = command + yahoo_rss_tag[i] + "&url="

        begin
            open(feed_url) do |feed|
              RSS::Parser.parse(feed.read , false).items.each do |item|

                index = (item.link).index("*")
                link = (item.link)[(index+1)..(item.link).length]

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