class SearchPanelSection < SitePrism::Section
  element :panel_toggle, '.filter-btn'
  element :usage_tab, '#usage-tab'
  elements :active_filters, '.filter-unit'
  elements :active_tab_elements, '.facet-list a'
end
