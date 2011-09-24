def get_news_from_tw_free (m,sleep_period)


udn_rss_url = [
    "http://www.libertytimes.com.tw/rss/fo.xml",
    "http://www.libertytimes.com.tw/rss/p.xml",
    "http://www.libertytimes.com.tw/rss/life.xml",
    "http://www.libertytimes.com.tw/rss/int.xml",
    "http://www.libertytimes.com.tw/rss/o.xml",
    "http://www.libertytimes.com.tw/rss/so.xml",
    "http://www.libertytimes.com.tw/rss/sp.xml",
    "http://www.libertytimes.com.tw/rss/e.xml",
    "http://www.libertytimes.com.tw/rss/stock.xml",
    "http://www.libertytimes.com.tw/rss/show.xml",
    "http://www.libertytimes.com.tw/rss/north.xml",
    "http://www.libertytimes.com.tw/rss/center.xml",
    "http://www.libertytimes.com.tw/rss/south.xml",
    "http://www.libertytimes.com.tw/rss/taipei.xml",
    "http://www.libertytimes.com.tw/rss/art.xml",

] ;


udn_focus_rss_tag = [
    "Focus/Special&area=Taiwan/",
    "Politics&area=Taiwan/",
    "Life&area=Taiwan/",
    "World&area=Taiwan/",
    "Special&area=Taiwan/",
    "Society&area=Taiwan/",
    "Sport&area=Taiwan/",
    "Business&area=Taiwan/",
    "Business&area=Taiwan/",
    "Entertainment&area=Taiwan/",
    "Local&area=Taiwan/North_TW/",
    "Local&area=Taiwan/Middle_TW/",
    "Local&area=Taiwan/South_TW/",
    "Local&area=Taiwan/North_TW/",
    "Life&area=Taiwan/",

 ] ;



  while true
    link = ""
    command = ""


    for i in (0..(udn_focus_rss_tag.length - 1))

        feed_url = udn_rss_url[i]

        if i == 0
          command = @host+ 'api/new_news?publish=yes&no_photo=no&focus_flag=yes&tags='
        else
          command = @host+ 'api/new_news?publish=yes&no_photo=no&focus_flag=no&tags='
        end

        command = command + udn_focus_rss_tag[i] + "&url="


        begin
             open(feed_url) do |feed|
               RSS::Parser.parse(feed.read , false).items.reverse.each do |item|

                 m.synchronize{

                   link = URI.encode(item.link)

                   puts '[FREE TW]  News Link :' + link

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

   end


  end
end

