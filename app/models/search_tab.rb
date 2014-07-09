# The majority of The Supplejack Website code is Crown copyright (C) 2014, New Zealand Government,
# and is licensed under the GNU General Public License, version 3. Some components are 
# third party components that are licensed under the MIT license or other terms. 
# See https://github.com/DigitalNZ/supplejack_website for details. 
# 
# Supplejack was created by DigitalNZ at the National Library of NZ and the Department of Internal Affairs. 
# http://digitalnz.org/supplejack

class SearchTab

  attr_reader :tab
  
  def initialize(tab='all')
    @tab = tab.present? ? tab : 'all'
  end

  def self.add_type_facets(search, type)
    if valid_type_facets.include?(type)
      search.and ||= {}
      search.and[:type] ||= {}
      search.and[:type] = type
    end
  end

  def self.valid_type_facets
    Search.new.facet_values('type').keys
  end

  def self.sorted_counts(counts)
    sorted = Hash[counts.sort_by{|k, v| v}.reverse[0..4]]
    sorted
  end

  def self.tab_label(name, count)
    %{#{name.capitalize} <span class="count">#{count}</span>}.html_safe
  end

  def all?
    tab == 'all'
  end
  
  def value
    @tab if tab.present?
  end

end