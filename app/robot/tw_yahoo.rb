require 'rss/2.0'
require 'open-uri'
require 'net/http'

    link = ""
    feed_url = 'http://tw.news.yahoo.com/rss/politics'
    open(feed_url) do |feed|
      RSS::Parser.parse(feed.read , false).items.each do |item|

        index = (item.link).index("*")
        link = (item.link)[(index+1)..(item.link).length]

        puts 'News Link :' + link

        # todo: check real tags from RSS doc.
        #
        open("http://localhost:3000/api/new_news?area=Taiwan&tags=Sport&url=" + link) {|f|
           f.each_line {|line| p line}
         }

        puts "\n"
      end


    end