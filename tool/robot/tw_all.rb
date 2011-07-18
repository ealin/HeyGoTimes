require 'rss/2.0'
require 'open-uri'
require 'net/http'
require 'thread'


@host = "http://localhost:3000/"
#@host = "http://heygotimes.heroku.com/"


@sleep_period = 50

m = Mutex.new


=begin
    ############  TW-Google   ############
require 'tw_google.rb'

Thread.start{
 get_news_from_tw_google(m,@sleep_period)
}
=end


=begin
      ############  TW-Yahoo   ############
require 'tw_yahoo.rb'

Thread.start{
 get_news_from_tw_yahoo(m,@sleep_period)
}



  ############  TW-Yahoo-beta   ############
require 'tw_yahoo_beta.rb'

Thread.start{
  get_news_from_tw_yahoo_beta(m,@sleep_period)
}


    ############  TW-Apple-focus   ############
require 'tw_apple_focus.rb'

Thread.start{
 get_news_from_tw_apple_focus(m,@sleep_period)
}



    ############  TW-Apple   ############
require 'tw_apple.rb'

Thread.start{
 get_news_from_tw_apple(m,@sleep_period)
}




    ############  TW-Google-Focus   ############
require 'tw_google_focus.rb'

Thread.start{
 get_news_from_tw_google_focus(m,@sleep_period)
}

=end


    ############  NOW-NEWS-Focus   ############
require './tw_nownews_focus.rb'

Thread.start{
 get_news_from_tw_nownews_focus(m,@sleep_period)
}



while true

end









