class Record
  include Supplejack::Record

  def image_url(options = {})
    size = '204'
    size = "#{options[:width]}" unless options == {}
    source_url = thumbnail_url || ''

    if options[:original]
      "#{THUMBNAIL_SERVER_URL}?src=#{CGI.escape(source_url)}"
    else
      "#{THUMBNAIL_SERVER_URL}?resize=#{size}&src=#{CGI.escape(source_url)}"
    end
  end
end
