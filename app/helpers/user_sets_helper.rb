# The majority of The Supplejack Website code is Crown copyright (C) 2014, New Zealand Government,
# and is licensed under the GNU General Public License, version 3. Some components are 
# third party components that are licensed under the MIT license or other terms. 
# See https://github.com/DigitalNZ/supplejack_website for details. 
# 
# Supplejack was created by DigitalNZ at the National Library of NZ and the Department of Internal Affairs. 
# http://digitalnz.org/supplejack

module UserSetsHelper
  def set_item_thumbnail(item, search=nil)
    image_options = {}
    search ||= Search.new
    search_options = search.options.try(:any?) ? search.options : nil

    image_options[:alt] ||= item.title
    image_options[:title] ||= image_options[:alt]

    content = content_tag(:div, link_to(image_tag(item.large_thumbnail_url, image_options), record_path(item.record_id, search: search_options)))
    content.html_safe
  end
end
