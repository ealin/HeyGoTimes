def parse_tw_free(url)
  begin
    stream = open(url)
    rescue
    # try again
    stream = open(url)
  end

  # get title
  #
  doc = Nokogiri::HTML(stream, nil, 'big5')
  node_set = doc.search('title')
  @parser_data[:title] = node_set[0].content

  doc.search('a').each do |data|
    str = data.to_s
    if str.include? ''
      url = data.get_attribute('content')
      if url != nil
        @parser_data[:image] = url
      end
      break
    end
  end





  node_set = doc.search('span.newcontent')
  #node_set = doc.search('a')
  url = node_set[0].get_attribute('href')
  if url != nil
    @parser_data[:image] = node_set[0].content
  end



#  node_set = doc.search('p')
  node_set = doc.search('p')
  @parser_data[:text] = node_set[0].content

end