def parse_tw_udn(url)
  begin
    stream = open(url)
    rescue
    # try again
    stream = open(url)
  end

  doc = Nokogiri::HTML(stream, nil, 'big5')

  doc.search('meta').each do |meta|
    if meta['property'] == 'og:title'
      @parser_data[:title] = meta['content']
    elsif meta['property'] == 'og:image'
      @parser_data[:image] = meta['content']
      break
    end
  end

  doc.search('div.story')
  node_set = doc.search('P')
  @parser_data[:text] = node_set[1].content

end