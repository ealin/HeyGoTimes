def get_news_from_us_yahoo (m,sleep_period)


      yahoo_rss_url = [
        "http://news.yahoo.com/rss/us",
        "http://news.yahoo.com/rss/education",
        "http://news.yahoo.com/rss/religion",
        "http://news.yahoo.com/rss/politics",
        "http://news.yahoo.com/rss/crime-trials",   #犯罪/審判
        "http://news.yahoo.com/rss/contributor-network",    #YAHOO user提供的新聞

        "http://news.yahoo.com/rss/business",
        "http://news.yahoo.com/rss/economy",
        "http://news.yahoo.com/rss/stock-markets",
        "http://news.yahoo.com/rss/earnings",
        "http://news.yahoo.com/rss/personal-finance",
        "http://news.yahoo.com/rss/business-press-releases",
        "http://news.yahoo.com/rss/taxes",
        "http://news.yahoo.com/rss/marketplace",

        "http://news.yahoo.com/rss/world",
        "http://news.yahoo.com/rss/middle-east",
        "http://news.yahoo.com/rss/europe",
        "http://news.yahoo.com/rss/latin-america",
        "http://news.yahoo.com/rss/africa",
        "http://news.yahoo.com/rss/asia",
        "http://news.yahoo.com/rss/canada",
        "http://news.yahoo.com/rss/australia-antarctica",

        "http://news.yahoo.com/rss/entertainment",
        "http://news.yahoo.com/rss/celebrity",
        "http://news.yahoo.com/rss/tv",
        "http://news.yahoo.com/rss/movies",
        "http://news.yahoo.com/rss/music",
        "http://news.yahoo.com/rss/reviews",
        "http://news.yahoo.com/rss/fashion",
        "http://news.yahoo.com/rss/books",
        "http://news.yahoo.com/rss/arts",

        "http://news.yahoo.com/rss/sports",
        "http://news.yahoo.com/rss/football",
        "http://news.yahoo.com/rss/baseball",
        "http://news.yahoo.com/rss/basketball",
        "http://news.yahoo.com/rss/college-sports",
        "http://news.yahoo.com/rss/soccer",
        "http://news.yahoo.com/rss/cycling",
        "http://news.yahoo.com/rss/hockey",
        "http://news.yahoo.com/rss/tennis",
        "http://news.yahoo.com/rss/golf",
        "http://news.yahoo.com/rss/world-cup",
        "http://news.yahoo.com/rss/boxing",
        "http://news.yahoo.com/rss/motorsports",
        "http://news.yahoo.com/rss/extreme-sports",

        "http://news.yahoo.com/rss/tech",
        "http://news.yahoo.com/rss/internet",
        "http://news.yahoo.com/rss/gadgets",
        "http://news.yahoo.com/rss/cell-phones",
        "http://news.yahoo.com/rss/social-media",
        "http://news.yahoo.com/rss/security",
        "http://news.yahoo.com/rss/open-source",
        "http://news.yahoo.com/rss/gaming",
        "http://news.yahoo.com/rss/science",
        "http://news.yahoo.com/rss/weather",
        "http://news.yahoo.com/rss/astronomy",
        "http://news.yahoo.com/rss/animal-pets",
        "http://news.yahoo.com/rss/dinosaurs-fossils",
        "http://news.yahoo.com/rss/biotech",
        "http://news.yahoo.com/rss/energy",
        "http://news.yahoo.com/rss/green",

        "http://news.yahoo.com/rss/politics",
        "http://news.yahoo.com/rss/white-house",
        "http://news.yahoo.com/rss/congress",
        "http://news.yahoo.com/rss/us-government",
        "http://news.yahoo.com/rss/the-courts",
        "http://news.yahoo.com/rss/opinion",
        "http://news.yahoo.com/rss/politics-press-releases",
        "http://news.yahoo.com/rss/elections-2012",

        "http://news.yahoo.com/rss/health",
        "http://news.yahoo.com/rss/sexual-health",
        "http://news.yahoo.com/rss/medications-drugs",
        "http://news.yahoo.com/rss/parenting-kids",
        "http://news.yahoo.com/rss/seniors-aging",
        "http://news.yahoo.com/rss/diseases-conditions",
        "http://news.yahoo.com/rss/vitality"
       ] ;


      yahoo_rss_tag = [
          "Locale",
          "Education",
          "Life",
          "Politics",
          "Society",
          "Special/Local",

          "Business","Business/Local","Business","Business","Business/Life","Business","Business/Life","Business",
          "World","World","World","World" ,"World","World","World","World",
          "Entertainment", "Entertainment","Entertainment","Entertainment","Entertainment","Entertainment","Entertainment","Entertainment","Art/Entertainment",
          "Sport","Sport","Sport","Sport","Sport","Sport","Sport","Sport","Sport","Sport","Sport","Sport","Sport","Sport",
          "Sci_Tech", "Sci_Tech/Internet","Sci_Tech","Sci_Tech","Sci_Tech/Internet","Sci_Tech","Sci_Tech","Sci_Tech/Life",
          "Sci_Tech","Sci_Tech/Life","Sci_Tech","Sci_Tech/Life","Sci_Tech","Sci_Tech","Sci_Tech","Sci_Tech",
          "Politics","Politics","Politics","Politics","Politics","Politics","Politics","Politics",

          #"Health","Health/Life","Health","Health","Health","Health","Health",
          "Life/Special","Life/Special","Life/Special","Life/Special","Life/Special","Life/Special","Life/Special",
      ] ;




    while true

      link = ""
      command = ""

      for i in (0..(yahoo_rss_tag.length - 1))


          feed_url = yahoo_rss_url[i]

          command = @host+ 'api/new_news?publish=yes&area=USA&tags='

          command = command + yahoo_rss_tag[i] + "&url="


            begin
                open(feed_url) do |feed|
                  RSS::Parser.parse(feed.read , false).items.reverse.each do |item|
                    m.synchronize{
                      link = URI.encode(item.link)

                      puts '[YAHOO US]  News Link :' + link

                      open(command + link) {|f|
                         f.each_line {|line| p line}
                       }

                      puts "\n"
                    }
                  end


                end

                sleep(@sleep_period)
            rescue OpenURI::HTTPError => the_error
                the_status = the_error.io.status[0] # => 3xx, 4xx, or 5xx
                next
            end
          #}

      end


    end

end
