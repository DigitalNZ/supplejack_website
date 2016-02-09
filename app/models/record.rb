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

  def image_url(options={})
    size = '204'
    size = "#{options[:width]}" unless options[:width].nil?
    source_url = self.thumbnail_url || ""

    if self.landing_url =~ /paperspast/
      pp_id = self.landing_url.gsub(/^.*d=(.*)$/, '\1')
      return "http://paperspast.natlib.govt.nz/cgi-bin/imageserver/imageserver.pl?oid=#{pp_id}&area=1&width=592&color=32&ext=gif&key="
    end


    if CGI.escape(source_url) == 'Unknown'
      return '/assets/temp-book.png'
    end


    if options[:original]
      "#{THUMBNAIL_SERVER_URL}?src=#{CGI.escape(source_url)}"
    else
      "#{THUMBNAIL_SERVER_URL}?resize=#{size}&src=#{CGI.escape(source_url)}"
    end

  end

end
