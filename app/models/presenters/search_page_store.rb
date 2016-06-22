module Presenters
  # Generates the server side state of the SearchPageStore on the client
  # The json outputted from here is inserted into the page and the client 
  # bootstraps the store using it
  #
  # It's also the only full description of the store state so it's a useful reference
  class SearchPageStore

    include ActionView::Helpers::NumberHelper

    # Provide all the subjects for search results page
    #
    # @Author: Taylor
    # @last modified Jeffery
    # @param search reprsents the search-results object 
    # @param category_counts represent the category statistics {"All"=>2413461, "Images"=>1483736, "Audio"=>6549, "Videos"=>16438}
    #
    # @return JSON that has first-level key filters, panel, searchTabs, and searchValue
    def call(search, category_counts)
      i_filters = search.params[:i].map{|facet, v| {facet: facet, value: v}}
      or_filters = search.params[:or].map do |facet, values|
        values.map{|v| {facet: facet, value: v}}
      end.flatten

      search_category = search.and[:category] || search.params[:tab]
      search_category = 'All' if search_category.nil? || search_category.empty?

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
          category_stats: category_count_formatting(category_counts)
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

    # Converts the hash of each category's count into decimal style string; also giving the key and count 
    #
    # == Parameters:
    # counts_hash::
    #  {"All"=>2413461, "Images"=>1483736, "Audio"=>6549, "Videos"=>16438}
    #
    # == Returns:
    # [{:category=>"All", :count=>"2,413,461"}, {:category=>"Images", :count=>"1,483,736"}, 
    # {:category=>"Audio", :count=>"6,549"}, {:category=>"Videos", :count=>"16,438"}]
    #
    def category_count_formatting(counts_hash)
      counts_hash.map do |type, count| 
        { category: type, 
          count: number_with_precision(count, delimiter: ',', precision: 0)
        }
      end
    end
  end
end
