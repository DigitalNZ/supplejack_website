# The majority of The Supplejack Website code is Crown copyright (C) 2014,
# New Zealand Government, and is licensed under the GNU General Public License,
#version 3. Some components are third party components that are licensed under
# the MIT license or other terms.
# See https://github.com/DigitalNZ/supplejack_website for details.
#
# Supplejack was created by DigitalNZ at the National Library of NZ and
# the Department of Internal Affairs.
# http://digitalnz.org/supplejack

class SearchTab
  TABS = %w(All Images Audio Videos Sets)
  attr_reader :tab

  def initialize(tab='All')
    @tab = tab.present? ? tab : 'All'
  end

  def self.add_category_facets(search, category)
    if valid_category_facets.include?(category)
      search.and ||= {}
      search.and[:category] ||= {}
      search.and[:category] = category
    end
  end

  def self.valid_category_facets
    Search.new.facet_values("category").keys
  end

  def self.sorted_counts(counts)
    sorted = {}
    TABS.each do |tab|
      sorted[tab] = counts[tab]
    end
    sorted
  end

  def self.tab_label(name, count)
    %{#{name.capitalize} <span class="count">#{count}</span>}.html_safe
  end

  def all?
    tab == 'All'
  end
  
  def value
    @tab if tab.present?
  end

  def more? 
    true if !all? && !images? && !sets? && !audio? && !videos? && SearchTab.valid_category_facets.include?(tab)
  end

  def more_label(count)
    more? ? %{#{tab.capitalize} <span class="count">#{count}</span><span class="more-arrow"></span>}.html_safe : %{More<span class="more-arrow"></span>}.html_safe
  end

  def self.more_categories_sum(category_counts)
    main_tabs  = ['All', 'Images', 'Audio', 'Videos', 'Sets']
    blacklist = [ 'Article', 'Music Score', 'Groups', 'Items', 'Websites', 'Research Papers', 'Magazines and Journals', 'Pieces', 'Unknown', 'Interactive', 'Video'] 

    blacklist.concat(main_tabs).each do |key|
      category_counts.delete(key)
    end

    Hash['More', category_counts.values.sum]
  end
end
