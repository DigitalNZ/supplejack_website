module RecordsHelper
  def record_thumbnail(record, search = nil)
    image_options = {}
    search ||= Search.new
    search_options = search.options.try(:any?) ? search.options : nil

    image_options[:alt] ||= record.title
    image_options[:title] ||= image_options[:alt]

    content = content_tag(:div, link_to(image_tag(record.image_url, image_options), record_path(record.id, search: search_options)))
    content.html_safe
  end

  def source_contributor_name(record)
    content_tag(:p, record.source_contributor_name.join(', ').html_safe)
  end

  def search_tab
    @search_tab ||= SearchTab.new(params[:tab])
  end

  def filter_facets
    # facets that we want to ignore/exclude
    blacklist = ['type']
    facets = Hash[@search.facets.map { |facet| [facet.name.to_s, facet.values] }]
    # Remove empty facets & unwanted facets
    facets.delete_if { |facet, values| values.empty? || blacklist.include?(facet) }
  end

  def filter_class(filter_name)
    filter_name.strip.gsub(/[^[:alnum:]]/, '').downcase
  end

  def date_parser_for(string)
    Date.parse string rescue return string
    Date.parse(string).strftime('%d %b %Y')
  end
end
