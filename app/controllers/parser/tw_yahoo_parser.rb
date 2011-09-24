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

  begin
    # raise exception when: http://tw.news.yahoo.com/article/url/d/a/110924/1/2zaom.html
    #
    node_set2 = doc.search('tr > td > label > a > img')
    @parser_data[:image] = node_set2[0]['src']
    node_set2 = doc.search('p')
    @parser_data[:text] = node_set2[0].content
  rescue
    @parser_data[:image] = nil
    if @parser_data[:text] == nil
      doc.search('meta').each do |data|
         str = data.to_s
         if str.include? "description"
           intro_content = data.get_attribute('content')
           if intro_content != nil
             @parser_data[:text] = intro_content
           end
         end
       end
    end
  end


end