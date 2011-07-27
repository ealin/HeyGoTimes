require 'rss/2.0'
require 'open-uri'
require 'net/http'
require 'thread'


@host = "http://localhost:3000/"
#@host = "http://heygotimes.heroku.com/"


@sleep_period = 50

m = Mutex.new

    ############  TUS-Google   ############
require './us_google.rb'

Thread.start{
 get_news_from_us_google(m,@sleep_period)
}




      ############  US-Yahoo   ############
require './us_yahoo.rb'

#Thread.start{
 get_news_from_us_yahoo(m,@sleep_period)
#}


