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

      temp_str = meta['content'].to_s
      if !( temp_str.include? 'func_udn.gif')
        @parser_data[:image] = meta['content']
      end
      break
    end
  end


  begin

    doc.search('div.story')
    node_set = doc.search('p')

    @parser_data[:text] = node_set[0].content
  rescue
    #raise exception in case of: http://udn.com/NEWS/DOMESTIC/DOM3/6609505.shtml  (with pic)
    #raise exception in case of: http://udn.com/NEWS/BREAKINGNEWS/BREAKINGNEWS2/6610232.shtml (1 paragraph only)

  end
end