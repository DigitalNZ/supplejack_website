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
    def image_url(opts={})
      width = opts.fetch(:width, 204)
      original = opts.fetch(:original, false)
      source_url = CGI.escape(self.thumbnail_url.to_s)

      if original
        "#{THUMBNAIL_SERVER_URL}?src=#{source_url}"
      else
        "#{THUMBNAIL_SERVER_URL}?resize=#{width}&src=#{source_url}"
      end
    end  
  end

  Item.send(:include, ItemDecorator)
end
