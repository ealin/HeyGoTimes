def news_parser(url)
  require 'open-uri'
  require 'nokogiri'

  require 'parser/tw_yahoo_parser.rb'
  require 'parser/tw_apple_parser.rb'
  require 'parser/tw_udn_parser.rb'
  require 'parser/tw_free_parser.rb'
  require 'parser/tw_now_parser.rb'

  require 'parser/fb_debugger_parser.rb'

  @parser_data = Hash.new

  if (url.include? 'tw.news.yahoo') && !(url.include? 'beta')
    parse_tw_yahoo(url)
  elsif url.include? 'udn.com'
    parse_tw_udn(url)
  elsif (url.include? 'libertytimes.feedsportal.com') || (url.include? 'www.libertytimes.com')
    parse_tw_free(url)
  elsif (url.include? 'rss.feedsportal.com') || (url.include? 'tw.nextmedia.com')
    parse_tw_apple(url)
  elsif (url.include? 'www.nownews.com')
    parse_tw_now(url)
  else
    parse_fb_debugger(url)
  end

end