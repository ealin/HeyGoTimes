module NewsHelper
  def get_news_content(url)
    require 'nokogiri'
    require 'open-uri'
    # @uri = "www.facebook.com/sharer.php?u=http://www.littleshell.net&t=littleshell的網站"
    @doc = Nokogiri::HTML(open(url))
    @body = @doc.at_css('body').text

    return @body
  end
end
