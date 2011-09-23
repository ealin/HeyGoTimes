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
  doc.search('td').each do |data|
    # puts data.content

    if (data.content == 'og:description')
      next_element = :content
      next
    elsif (data.content == 'og:title')
      next_element = :title
      next
    elsif (data.content == 'og:image')
      next_element = :image
      next
    end

    if (next_element == :content)
      text = data.content
    elsif (next_element == :image)
      image_url = data.search('a').first['href']

    elsif (next_element == :title)
      title = data.content
    end

    next_element = :normal

  end

  @parser_data[:title]=title
  @parser_data[:image]=image_url
  @parser_data[:text]=text

end