require 'rss/2.0'
require 'open-uri'
require 'net/http'

@host = "http://localhost:3000/"
#@host = "http://heygotimes.heroku.com/"


    yahoo_beta_rss_url = [
        "http://beta.tw.news.yahoo.com/rss/taipei",
        "http://beta.tw.news.yahoo.com/rss/north-taiwan",
        "http://beta.tw.news.yahoo.com/rss/mid-taiwan",
        "http://beta.tw.news.yahoo.com/rss/south-taiwan",
        "http://beta.tw.news.yahoo.com/rss/east-taiwan",
        "http://beta.tw.news.yahoo.com/rss/local/",

      "http://beta.tw.news.yahoo.com/rss/entertainment",
      "http://beta.tw.news.yahoo.com/rss/celebrity",
      "http://beta.tw.news.yahoo.com/rss/music",
      "http://beta.tw.news.yahoo.com/rss/tv-radio",
      "http://beta.tw.news.yahoo.com/rss/movies",
      "http://beta.tw.news.yahoo.com/rss/jp-kr",

      "http://beta.tw.news.yahoo.com/rss/sports",
      "http://beta.tw.news.yahoo.com/rss/basketball",
      "http://beta.tw.news.yahoo.com/rss/baseball",
      "http://beta.tw.news.yahoo.com/rss/golf",
      "http://beta.tw.news.yahoo.com/rss/tennis",
      "http://beta.tw.news.yahoo.com/rss/other-sports",

      "http://beta.tw.news.yahoo.com/rss/politics",

      "http://beta.tw.news.yahoo.com/rss/society",

      "http://beta.tw.news.yahoo.com/rss/world",
      "http://beta.tw.news.yahoo.com/rss/asia-australia",
      "http://beta.tw.news.yahoo.com/rss/china",
      "http://beta.tw.news.yahoo.com/rss/america",
      "http://beta.tw.news.yahoo.com/rss/euro-africa",

      "http://beta.tw.news.yahoo.com/rss/finance",
      "http://beta.tw.news.yahoo.com/rss/stock",
      "http://beta.tw.news.yahoo.com/rss/industry",
      "http://beta.tw.news.yahoo.com/rss/economy",
      "http://beta.tw.news.yahoo.com/rss/real-estate",
      "http://beta.tw.news.yahoo.com/rss/money-career",

      "http://beta.tw.news.yahoo.com/rss/lifestyle",
      "http://beta.tw.news.yahoo.com/rss/weather",
      "http://beta.tw.news.yahoo.com/rss/consumption",
      "http://beta.tw.news.yahoo.com/rss/travel",
      "http://beta.tw.news.yahoo.com/rss/education",
      "http://beta.tw.news.yahoo.com/rss/art",
      "http://beta.tw.news.yahoo.com/rss/lifestyle",

      "http://beta.tw.news.yahoo.com/rss/health",
      "http://beta.tw.news.yahoo.com/rss/disease",
      "http://beta.tw.news.yahoo.com/rss/beauty",

      "http://beta.tw.news.yahoo.com/rss/technology",
      "http://beta.tw.news.yahoo.com/rss/information-3c",
      "http://beta.tw.news.yahoo.com/rss/science" ] ;


    yahoo_beta_rss_tag = [
        "Local","Local","Local","Local","Local","Local",
        "Entertainment","Entertainment","Entertainment","Entertainment","Entertainment","Entertainment",
        "Sport","Sport","Sport","Sport","Sport","Sport",
        "Politics",
        "Society",
        "World","World","World","World","World",
        "Business","Business","Business","Business","Business","Business",
        "Life","Life","Life",
        "Travel",
        "Education",
        "Art",
        "Life",
        "Health","Health","Health",
        "Sci_Tech","Sci_Tech","Sci_Tech"] ;


    yahoo_beta_rss_area = [
        "Taiwan/North_TW/","Taiwan/North_TW/","Taiwan/Middle_TW/","Taiwan/South_TW/","Taiwan/East_TW/","Taiwan/",
        "Taiwan/","Taiwan/","Taiwan/","Taiwan/","Taiwan/","Taiwan/",
        "Taiwan/","Taiwan/","Taiwan/","Taiwan/","Taiwan/","Taiwan/",
        "Taiwan/",
        "Taiwan/",
        "Taiwan/","Taiwan/","Taiwan/","Taiwan/","Taiwan/",
        "Taiwan/","Taiwan/","Taiwan/","Taiwan/","Taiwan/","Taiwan/",
        "Taiwan/","Taiwan/","Taiwan/",
        "Taiwan/",
        "Taiwan/",
        "Taiwan/",
        "Taiwan/",
        "Taiwan/","Taiwan/","Taiwan/",
        "Taiwan/","Taiwan/","Taiwan/"] ;



    link = ""
    command = ""

while true

    for i in (0..(yahoo_beta_rss_tag.length - 1))


        feed_url = yahoo_beta_rss_url[i]

        command = @host+ 'api/new_news?publish=yes&tags='

        command = command + yahoo_beta_rss_tag[i] + '&area=' + yahoo_beta_rss_area[i] + "&url="

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
