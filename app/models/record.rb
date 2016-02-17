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
  def image_url(size: 204, original: false)
    source_url = CGI.escape(self.thumbnail_url.to_s)

    return '/assets/temp-book.png' if source_url == NO_THUMBNAIL_URL

    if self.landing_url =~ /paperspast/
      pp_id = self.landing_url.gsub(/^.*d=(.*)$/, '\1')
      return 'http://paperspast.natlib.govt.nz/cgi-bin/imageserver/'\
             "imageserver.pl?oid=#{pp_id}&area=1&width=592&color=32&ext=gif&key="
    end

    if original
      "#{THUMBNAIL_SERVER_URL}?src=#{source_url}"
    else
      "#{THUMBNAIL_SERVER_URL}?resize=#{size}&src=#{source_url}"
    end
  end
end
