class SearchPanelSection < SitePrism::Section
  element :panel_toggle, '.filter-btn'
  elements :active_filters, '.filter-unit'
end
