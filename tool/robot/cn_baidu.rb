def get_news_from_cn_Baidu (m,sleep_period)


cn_baidu_rss_url = [
  "http://news.baidu.com/n?cmd=1&class=internet&tn=rss",
  "http://rss.it.sohu.com/rss/hulianwang.xml",

] ;


cn_baidu_rss_tag = [
    "Internet",
    "Internet",

 ] ;




  while true
    link = ""
    command = ""


    for i in (0..(cn_baidu_rss_tag.length - 1))

        feed_url = cn_baidu_rss_url[i]

        command = @host+ 'api/new_news?publish=no&focus_flag=yes&area=Taiwan/&tags='


        command = command + cn_baidu_rss_tag[i] + "&url="

          begin
              open(feed_url) do |feed|
                RSS::Parser.parse(feed.read , false).items.reverse.each do |item|
                  m.synchronize{

                    link = URI.encode(item.link)
                    puts '[Baidu Internet]  News Link :' + link


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

