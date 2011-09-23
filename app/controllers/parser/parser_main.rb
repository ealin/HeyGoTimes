def news_parser(url)
  require 'open-uri'
  require 'nokogiri'

  require 'parser/tw_yahoo_parser.rb'
  require 'parser/fb_debugger_parser.rb'

  @parser_data = Hash.new

  if url.include? 'tw.news.yahoo'
    type = :tw_yahoo
  end

  if type == :tw_yahoo
    parse_tw_yahoo(url)
  else
    parse_fb_debugger(url)
  end
end