# frozen_string_literal: true

class Record
  include Supplejack::Record

  def image_url(options = {})
    size = options[:width] || '204'
    source_url = thumbnail_url || ''

    return "#{THUMBNAIL_SERVER_URL}?src=#{CGI.escape(source_url)}" if options[:original]

    "#{THUMBNAIL_SERVER_URL}?resize=#{size}&src=#{CGI.escape(source_url)}"
  end
end
