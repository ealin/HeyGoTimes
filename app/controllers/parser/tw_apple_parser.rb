def parse_tw_apple(url)
  begin
    stream = open(url)
    rescue
    # try again
    stream = open(url)
  end



  # get title
  #
  doc = Nokogiri::HTML(stream, nil, 'utf-8')
  node_set = doc.search('title')
  @parser_data[:title] = node_set[0].content

  # get photo
  #
  doc.search('meta').each do |data|
    str = data.to_s
    if str.include? 'og:image'
      url = data.get_attribute('content')
      if url != nil
        @parser_data[:image] = url
      end
      break
    end
  end

  if @parser_data[:image] == nil
    doc.search('a').each do |data|
      str = data.to_s
      if str.include? 'pic_frame thickbox'
        url = data.get_attribute('href')
        if url != nil
          @parser_data[:image] = url
        end
        break
      end
    end

  end

  if @parser_data[:image] == nil
    doc.search('img').each do |data|
      str = data.to_s
      if str.include? 'pic_frame'
        url = data.get_attribute('src')
        if url != nil
          @parser_data[:image] = url
        end
        break
      end
    end

  end

  # get content
  #
  doc.search('p').each do |data|
    str = data.to_s
    if str.include? 'summary'
      content = data.content

      if content.length > 210
        content = content.slice(0,208)
        content += '...'

      end

      @parser_data[:text] = content

      break
    end
  end

  if(@parser_data[:text] == nil)
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