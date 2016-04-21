class SearchPanelSection < SitePrism::Section
  element :panel_toggle, '.filter-btn'
  element :close_button, '.close-filters'
  element :usage_tab, '#usage-tab'
  element :panel, '#search_filter'
  elements :active_filters, '.filter-unit'
  elements :active_tab_elements, '.facet-list a'
end
