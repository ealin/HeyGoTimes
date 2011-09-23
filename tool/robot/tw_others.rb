def get_tw_other_news (m,sleep_period)


google_focus_rss_url = [
  #"http://news.google.com.tw/news?pz=1&cf=all&ned=tw&hl=zh-TW&output=rss"   ,

  "http://tech.qq.com/web/front/rss.xml",

  "http://tw.money.yahoo.com/rss/edbf/d_e_MN2/",
  #"http://tw.money.yahoo.com/rss/edbf/d_e_MN4/",
  "http://tw.money.yahoo.com/rss/edbf/d_e_MN5/",
  "http://tw.money.yahoo.com/rss/edbf/d_e_MR4/",
  "http://tw.money.yahoo.com/rss/edbf/d_e_MN1"


] ;


google_focus_rss_tag = [
    #"Focus/Special",

    "Internet",

    "Business",
    #"Business",
    "Business/World",
    "Business/World",
    "Business"


 ] ;




  while true
    link = ""
    command = ""


    for i in (0..(google_focus_rss_tag.length - 1))

        feed_url = google_focus_rss_url[i]

        #if i == 0
          command = @host+ 'api/new_news?publish=yes&focus_flag=yes&area=Taiwan/&tags='
        #else
        #  command = @host+ 'api/new_news?publish=no&focus_flag=yes&area=Taiwan/&tags='
        #end


        command = command + google_focus_rss_tag[i] + "&url="

          begin
              open(feed_url) do |feed|
                RSS::Parser.parse(feed.read , false).items.reverse.each do |item|
                  m.synchronize{

                    link = URI.encode(item.link)

                    if i == 0
                      puts '[QQ IT]  News Link :' + link
                    else
                      puts '[YAHOO BUSINESS]  News Link :' + link
                    end


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

