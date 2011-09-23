def parse_tw_yahoo(url)
  begin
    stream = open(url)
    rescue
    # try again
    stream = open(url)
  end

  doc = Nokogiri::HTML(stream, nil, 'utf-8')
  node_set = doc.search('title')
  @parser_data[:title] = node_set[0].content

  node_set = doc.search('tr > td > label > a > img')
  @parser_data[:image] = node_set[0]['src']

  node_set = doc.search('p')
  @parser_data[:text] = node_set[0].content
end