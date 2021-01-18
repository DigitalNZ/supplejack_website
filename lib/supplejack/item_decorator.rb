# frozen_string_literal: true

require 'cgi'

module Supplejack
  module ItemDecorator
    def image_url(options = {})
      size = options[:width] || 204
      source_url = thumbnail_url || ''

      if options[:original]
        "#{THUMBNAIL_SERVER_URL}?src=#{CGI.escape(source_url)}"
      else
        "#{THUMBNAIL_SERVER_URL}?resize=#{size}&src=#{CGI.escape(source_url)}"
      end
    end
  end

  Item.include ItemDecorator
end
