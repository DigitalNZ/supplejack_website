# The majority of The Supplejack Website code is Crown copyright (C) 2014, New Zealand Government,
# and is licensed under the GNU General Public License, version 3. Some components are 
# third party components that are licensed under the MIT license or other terms. 
# See https://github.com/DigitalNZ/supplejack_website for details. 
# 
# Supplejack was created by DigitalNZ at the National Library of NZ and the Department of Internal Affairs. 
# http://digitalnz.org/supplejack

require 'cgi'

module Supplejack
  module ItemDecorator
    def image_url(options={})
      size = options[:width] || 204
      source_url = self.thumbnail_url || ''

      if options[:original]
        "#{THUMBNAIL_SERVER_URL}?src=#{CGI.escape(source_url)}"
      else
        "#{THUMBNAIL_SERVER_URL}?resize=#{size}&src=#{CGI.escape(source_url)}"
      end
    end
  end

  Item.send(:include, ItemDecorator)
end
