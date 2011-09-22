def news_parser(url)
  require 'open-uri'
  require 'nokogiri'

  require 'parser/tw_yahoo.rb'
  require 'parser/fb_debugger.rb'

  @parser_data = Hash.new

  if url.include? 'title'
    type = :tw_yahoo
  end

  if type == :tw_yahoo
    # parse_tw_yahoo
    fb_debugger(url)
  else
    fb_debugger(url)
  end
end