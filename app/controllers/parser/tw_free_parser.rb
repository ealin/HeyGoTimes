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

  # get content
  #
  begin
    node_set = doc.search('.//span[@id="newcontent"]//p')
    intro_str = node_set[0].content
    if intro_str != nil
      @parser_data[:text] = intro_str
    end
  rescue

  end


  # get photo
  #
  begin
    node_set = doc.search('.//span[@id="newcontent"]//a')
    url = node_set[0].get_attribute('href')

    if url != nil
      index = url.index("pic=http://www.")
      url2 = url[index+4..url.length]
      url3 = url2.gsub("/images/bigPic/","/images/")
      @parser_data[:image] = url3
    end
  rescue

  end

return

end