def news_parser(url)
  require 'open-uri'
  require 'nokogiri'

  require 'parser/tw_yahoo_parser.rb'
  require 'parser/tw_apple_parser.rb'
  require 'parser/tw_udn_parser.rb'
  require 'parser/fb_debugger_parser.rb'

  @parser_data = Hash.new

  if url.include? 'beta.tw.news.yahoo.com'
    parse_fb_debugger(url)
  elsif url.include? 'tw.news.yahoo'
    parse_tw_yahoo(url)
  elsif url.include? 'udn.com'
    parse_tw_udn(url)
  elsif (url.include? 'rss.feedsportal.com') || (url.include? 'tw.nextmedia.com')
    parse_tw_apple(url)
  else
    parse_fb_debugger(url)
  end

end