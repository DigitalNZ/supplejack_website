module Presenters
  # Generates the server side state of the SearchPageStore on the client
  # The json outputted from here is inserted into the page and the client 
  # bootstraps the store using it
  #
  # It's also the only full description of the store state so it's a useful reference
  class SearchPageStore

    include ActionView::Helpers::NumberHelper

    def call(search, category_counts)
      i_filters = search.params[:i].map{|facet, v| {facet: facet, value: v}}
      or_filters = search.params[:or].map do |facet, values|
        values.map{|v| {facet: facet, value: v}}
      end.flatten

      search_category = search.and[:category] || search.params[:tab] || 'All'

      facets = search.facets || []
      {
        filters: i_filters + or_filters,
        panel: {
          filtersToApply: false,
          buttonText: 'Close',
          open: false,
          # reduce(&:merge) returns nil if the array is empty
          facets: facets.map do |facet| 
            values = filter_facet_values(facet.name, facet.values)
            {facet.name => values}
          end.reduce(&:merge) || [],
          tab: 0
        },
        searchTabs: {
          active_tab: search_category,
          category_stats: search_category_values(category_counts)
        },
        searchValue: search.params[:text]
      }.to_json
    end

    private

    def filter_facet_values(name, values)
      if name == 'decade'
        Hash[values.select do |year, _|
          year = year.to_i
          year >= 1000 && year <= Time.now.year
        end]
      else
        values
      end
    end

    def search_category_values(counts_hash)
      counts_hash.map do |type, count| 
        { category: type, 
          count: number_with_precision(count, delimiter: ',', precision: 0)
        }
      end
    end
  end
end
