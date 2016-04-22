module Presenters
  class SearchPageStore
    def call(search)
      i_filters = search.params[:i].map{|facet, v| {facet: facet, value: v}}
      or_filters = search.params[:or].map do |facet, values|
        values.map{|v| {facet: facet, value: v}}
      end.flatten
      facets = search.facets || []

      {
        filters: i_filters + or_filters,
        panel: {
          filtersToApply: false,
          buttonText: 'Close',
          open: false,
          # reduce(&:merge) returns nil if the array is empty
          facets: facets.map {|facet| {facet.name => facet.values}}.reduce(&:merge) || [],
          tab: 0
        },
        searchValue: search.params[:text]
      }.to_json
    end
  end
end
