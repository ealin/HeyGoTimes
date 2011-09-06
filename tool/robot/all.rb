require 'rss/2.0'
require 'open-uri'
require 'net/http'
require 'thread'


#@host = "http://localhost:3000/"
@host = "http://heygotimes-robot.heroku.com/"


@sleep_period = 2
@rank_reduction_period = 43200 # 12 hours

m = Mutex.new


      ############  TW-Yahoo   ############
require './tw_yahoo.rb'

Thread.start{
 get_news_from_tw_yahoo(m,@sleep_period)
}




    ############  TW-Apple-focus   ############
require './tw_apple_focus.rb'

Thread.start{
 get_news_from_tw_apple_focus(m,@sleep_period)
}



    ############  TW-Apple   ############
require './tw_apple.rb'

Thread.start{
 get_news_from_tw_apple(m,@sleep_period)
}



  ############  TW-Yahoo-beta   ############
require './tw_yahoo_beta.rb'

Thread.start{
  get_news_from_tw_yahoo_beta(m,@sleep_period)
}



    ############  NOW-NEWS-Focus   ############
require './tw_nownews.rb'

Thread.start{
 get_news_from_tw_nownews(m,@sleep_period)
}





    ############  NOW-NEWS-Focus   ############
require './tw_nownews_focus.rb'

Thread.start{
 get_news_from_tw_nownews_focus(m,@sleep_period)
}



      ############  TW-UDN   ############
require './tw_udn.rb'

Thread.start{
 get_news_from_tw_udn(m,@sleep_period)
}





#!!!!!!!!!!!!!!!!!!!!! US NEWS START HERE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!



    ############  US-Google   ############
require './us_google.rb'

Thread.start{
 get_news_from_us_google(m,@sleep_period)
}




      ############  US-Yahoo   ############
require './us_yahoo.rb'

Thread.start{
 get_news_from_us_yahoo(m,@sleep_period)
}


      ############  automatic news rank reduction   ############
require './rank_reduction.rb'

Thread.start{
 hot_news_rank_reduction(m,@rank_reduction_period)
}




############  TW-Google-Focus   ############
require './tw_others.rb'

#Thread.start{
    get_tw_other_news(m,@sleep_period)
#}


############  TW-Google-Focus   ############
#require './cn_baidu.rb'

#Thread.start{
#    get_news_from_cn_Baidu(m,@sleep_period)
#}



