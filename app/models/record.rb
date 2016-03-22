# The majority of The Supplejack Website code is Crown copyright (C) 2014,
# New Zealand Government, and is licensed under the GNU General Public License,
#version 3. Some components are third party components that are licensed under
# the MIT license or other terms.
# See https://github.com/DigitalNZ/supplejack_website for details.
#
# Supplejack was created by DigitalNZ at the National Library of NZ and
# the Department of Internal Affairs.
# http://digitalnz.org/supplejack

class Record
  include Supplejack::Record
  
  NO_THUMBNAIL_URL = "Unknown"

  # Returns the URL to request this Records image from
  # the Thumbnailer server
  #
  # @param size [Integer] the width of the thumbnail to be returned, ignored if `original` is truthy
  # @param original [Boolean] whether to resize the thumbnail or not
  # @returns [String] the full URL to retrieve the thumbnailed image from
  def image_url(options={})
      options.reverse_merge!({width: 204, height: nil, large_size: nil, original: false})

      thumbnail_endpoint =  options[:large_size] ? 
      "#{THUMBNAIL_SERVER_URL}/from_large/#{options[:large_size]}/" : 
      "#{THUMBNAIL_SERVER_URL}/"

      size = [options[:width]]
      size << options[:height] if options[:height]
      size = size.join("x")

      if large_thumbnail_url.present?
        image_url = large_thumbnail_url
      elsif thumbnail_url.present? && !thumbnail_url.match(/digitalnz.org\/images\/thumbnails/)
        image_url = thumbnail_url
      else
        image_url = nil
      end

      if image_url.present?
        if options[:original] == false
          "#{thumbnail_endpoint}?resize=#{size}&src=#{CGI.escape(image_url)}"
        else
          image_url
        end
      elsif papers_past?
        url = landing_url
        url.match(/search&d=(.+)$/)
        options[:height] ||= 148
        papers_past_id = $1
        papers_past_thumbnail_url = "http://paperspast.natlib.govt.nz/cgi-bin/imageserver/imageserver.pl?oid=#{papers_past_id}&area=all&width=#{options[:width].to_s.gsub(/[<>!%]/, '')}&maxheight=#{options[:height].to_s.gsub(/[<>!%]/, '')}&color=32&ext=gif"
        return "#{thumbnail_endpoint}?resize=#{size}&src=#{CGI.escape(papers_past_thumbnail_url)}"
      else
        return nil
      end    
  end

  def large_image?
    large_thumbnail_url.present? || (papers_past? && image_url.present?)
  end
end