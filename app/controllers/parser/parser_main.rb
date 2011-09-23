def news_parser(url)
  require 'open-uri'
  require 'nokogiri'

  require 'parser/tw_yahoo_parser.rb'
  require 'parser/tw_udn_parser.rb'
  require 'parser/fb_debugger_parser.rb'

  @parser_data = Hash.new

  if url.include? 'tw.news.yahoo'
    parse_tw_yahoo(url)
  elsif url.include? 'udn.com'
    parse_tw_udn(url)
  else
    parse_fb_debugger(url)
  end

end