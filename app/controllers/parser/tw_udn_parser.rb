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

  begin
    #raise exception in case of: http://udn.com/NEWS/DOMESTIC/DOM3/6609505.shtml

    doc.search('div.story')
    node_set = doc.search('p')
    @parser_data[:text] = node_set[0].content
  rescue
    # a little complicate
  end
end