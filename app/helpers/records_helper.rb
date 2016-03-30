# The majority of The Supplejack Website code is Crown copyright (C) 2014,
# New Zealand Government, and is licensed under the GNU General Public License,
#version 3. Some components are third party components that are licensed under
# the MIT license or other terms.
# See https://github.com/DigitalNZ/supplejack_website for details.
#
# Supplejack was created by DigitalNZ at the National Library of NZ and
# the Department of Internal Affairs.
# http://digitalnz.org/supplejack

module RecordsHelper

  def record_thumbnail(record, search=nil)
    image_options = {}
    search ||= Search.new
    search_options = search.options.try(:any?) ? search.options : nil

    image_options[:alt] ||= record.title
    image_options[:title] ||= image_options[:alt]

    content = content_tag(
      :div, 
      link_to(
        image_tag(record.image_url, image_options), 
        record_path(record.id, search: search_options)
      )
    )
    content.html_safe
  end

  def display_record_graphic(record)
    format_large_image(record) || placeholder_image(record)    
  end

  def format_large_image(record)
    return false unless record.large_image?
    image_tag(record.image_url(width: 520, height: 840, large_size: 664), alt: image_alt_string(record), itemprop: "image", class: 'image-box')
  end


  def image_alt_string(record)
    truncate([record.title, record.content_partner].delete_if{|element| element.blank?}.join(' - '), length: 120, separator: '...')
  end

  def placeholder_image(record)
    search_options = search.options.try(:any?) ? search.options : nil

    image = record.image_url.present? ? image_tag(record.image_url, alt: record.title, class: "image-box") : image_tag("images-no-repeat/bg-no-preview.png", alt: t('records.no_preview'), class: "no-preview")
    image = content_tag(:div, image.html_safe, class: "image")
    image = link_to(image, record_path(record.id, search: search_options)) if record.large_thumbnail_url
    
    css_class = "placeholder-image"
    css_class << " image-box" unless request.path.starts_with?(user_sets_path)
    content_tag(:div, class: css_class) do
      image + link_for_placeholder(record)
    end
  end

  def link_for_placeholder(record)
    content_tag(:div, "#{t('records.click_to')}#{link_to(t('records.view_external_item'), record.source_url)}".html_safe, class: "link")
  end    

  # def record_thumbnail(record, search=nil, options={}, html_options={})
  #   image_options = html_options[:image_html] || {}
  #   container_options = html_options[:container_html] || {}
  #   text_image_options = html_options[:text_image_html] || {}
  #   link_options = html_options[:link_html] || {}

  #   search ||= Search.new
  #   search_options = search.options.try(:any?) ? search.options : nil

  #   options.reverse_merge!({width: 260, height: record.thumbnail_height, large_size: 664, caption: false, use_known_height: false})

  #   image_options[:alt] ||= image_alt_string(record)
  #   image_options[:title] ||= image_options[:alt]

  #   if options[:use_known_height]
  #     ratio = record.large_thumbnail_aspect_ratio
  #     ratio ||= record.thumbnail_aspect_ratio

  #     if ratio.present?
  #       height = (158 / ratio)
  #       height = height.ceil
  #       height = 280 if height > 280 # 280 is max-height of image in CSS
  #       link_options[:style] = "height: #{height}px"
  #     else
  #       link_options[:class] = "unknown-height"
  #     end
  #   end

  #   content = ""
  #   if record.image_url(options).present?
  #     container_options[:class] ||= "image"
  #     content = content_tag(:div, link_to(image_tag(record.image_url(options), image_options), record_path(record.id, search: search_options), link_options), container_options)
  #   else
  #     content = link_to text_frame(record, class: text_image_options[:class]), record_path(record.id, search: search_options)
  #   end

  #   if options[:caption]
  #     content += content_tag(:div, truncate(record.title.to_s, length: 80), class: 'title')
  #     content += content_tag(:div, link_to(record.display_collection, record_path(record.id, search: search.try(:url_options))), class: 'collection')
  #   end
  #   content.html_safe
  # end

  def source_contributor_name(record)
    content_tag(:p, record.source_contributor_name.join(', ').html_safe)
  end

  def search_tab
    @search_tab ||= SearchTab.new(params[:tab])
  end

  def filter_facets
    # facets that we want to ignore/exclude
    blacklist = ['type']
    facets = Hash[ @search.facets.map { |facet| [facet.name.to_s, facet.values] }]
    
    # Remove empty facets & unwanted facets
    facets = facets.delete_if { |facet, values| values.empty? || blacklist.include?(facet)}
  end

  def filter_class(filter_name)
    filter_name.strip.gsub(/[^[:alnum:]]/, "").downcase
  end

  def date_parser_for(string)
    Date.parse string rescue return string
    return Date.parse(string).strftime("%d %b %Y")
  end

  def more_categories_list(categories)
    list = %{}

    categories.each do |category, count|
      count = number_with_precision(count, delimiter: ',', precision: 0)
      label  = %{#{category} <span class="count">#{count}</span>}.html_safe
      # label  = %{#{category}}.html_safe
      tab_id = category.downcase.tr_s(" &", "_")
      
      options = search.params
      [:tab, :page, :utf8, :commit, :facets, :facets_per_page].each {|param| options.delete(param)}

      link = link_to label, 
        records_path(search_tab_options(options, category)), 
        id: tab_id

      list << %{<li>#{link}</li><hr>}
    end
    list.html_safe
  end

  def more_tab_title
    SearchTab::TABS.include?(params[:tab]) ? 'More' : params[:tab] || 'More'
  end

  def more_tab_count(tab, categories)
    count = tab == 'More' ? categories.values.sum : categories[tab]
    number_with_precision(count, delimiter: ',', precision: 0)
  end

  def facet_name(name)
    case name 
    when 'decade'
      'Date'
    when 'primary_collection'
      'Collection'
    else
      name.titleize
    end
  end  

  def facet_list(facet)
    if facet[0] == 'decade'
      Hash[facet[1].collect{|k,v| [k,v] if (0..2100) === k.to_i }.compact.sort.reverse]
      # Hash[facet[1].sort.reverse]
    else 
      Hash[facet[1].sort]
    end
  end

end
