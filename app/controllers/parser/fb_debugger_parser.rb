def parse_fb_debugger(url)

  # url = 'http://developers.facebook.com/tools/lint/?url=' + URI.encode(params[:url])
  url = 'https://developers.facebook.com/tools/debug/og/object?q=' + url
  # url = 'https://www.facebook.com/sharer/sharer.php?u=' + params[:url]
  next_element = ''
  title = ''
  image_url = ''
  text = ''

  begin
    stream = open(url)
    rescue
    # try again
    stream = open(url)
  end

  doc = Nokogiri::HTML(stream, nil, 'utf-8')


  #@error = @doc.search('lint > lint_error')
  #if (@error != nil)
  #  @data['ret'] = 'bad url'
  #end

  # @body = @doc.at_css('body').text
  fetched = true
  doc.search('td', 'b').each do |data|
    # puts data.content

    if (data.content == 'Data Source')
      fetched = false
      next
    end

    if fetched == false
      if data.content.include? 'og:title'
        start_pos = data.content.index('content')
        title = data.content[start_pos+9..-5]
        fetched = true
        elsif data.content.include? 'og:description'
        start_pos = data.content.index('content')
        text = data.content[start_pos+9..-4]
        fetched = true
        elsif data.content.include? 'og:image'
        start_pos = data.content.index('http')
        image_url = data.content[start_pos..-1]
        fetched = true
        elsif data.content.include? 'title'
        end_pos = data.content.index('extracted')
        if end_pos == nil
          title = data.content[1..-2]
        else
          title = data.content[1..end_pos-3]
        end

        fetched = true
      elsif data.content.include? 'description'
        end_pos = data.content.index('..')
        if end_pos == nil
          end_pos = data.content.index('extracted')
          if end_pos == nil
            end_pos = 0
          end
          text = data.content[1..end_pos-1]
        else
          text = data.content[1..end_pos+1]
        end

        fetched = true
      end
    end

  end

  @parser_data[:title]=title
  @parser_data[:image]=image_url
  @parser_data[:text]=text

end