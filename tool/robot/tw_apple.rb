require 'rss/2.0'
require 'open-uri'
require 'net/http'

@host = "http://localhost:3000/"
#@host = "http://heygotimes.heroku.com/"


    apple_rss_url = [
      "http://tw.news.yahoo.com/rss/politics",
] ;


    apple_rss_tag = [
        "Politics",
 ] ;


   apple_fouce_flag = [
      "Politics",
   ] ;


    link = ""
    command = ""

while true

    for i in (0..(yahoo_rss_tag.length - 1))


        feed_url = yahoo_rss_url[i]

        command = @host+ 'api/new_news?publish=yes&area=Taiwan/&tags='

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
