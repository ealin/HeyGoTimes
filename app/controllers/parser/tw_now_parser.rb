def parse_tw_now(url)
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

  # get photo
  #
  doc.search('meta').each do |data|
    str = data.to_s
    if str.include? 'og:image'
      url = data.get_attribute('content')
      if url != nil && url != 'http://static.nownews.com/newspic/0/s'
        @parser_data[:image] = url
      end
      break
    end
  end


  # get content
  #

    doc.search('meta').each do |data|
       str = data.to_s
       if str.include? "description"
         intro_content = data.get_attribute('content')
         if intro_content != nil
           @parser_data[:text] = intro_content
           break
         end
       end
     end

end