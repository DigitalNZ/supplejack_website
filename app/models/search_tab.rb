# frozen_string_literal: true

class SearchTab
  TABS = %w[All Images Audio Videos Sets].freeze
  attr_reader :tab

  def initialize(tab = 'All')
    @tab = tab.present? ? tab : 'All'
  end

  def self.add_category_facets(search, category)
    return unless valid_category_facets.include?(category)

    search.and ||= {}
    search.and[:category] ||= {}
    search.and[:category] = category
  end

  def self.valid_category_facets
    Search.new.facet_values('category').keys
  end

  def self.sorted_counts(counts)
    sorted = {}
    TABS.each do |tab|
      sorted[tab] = counts[tab]
    end
    sorted
  end

  def self.tab_label(name, count)
    %(#{name.capitalize} <span class="count">#{count}</span>).html_safe
  end

  def all?
    tab == 'All'
  end

  def value
    @tab
  end
end
