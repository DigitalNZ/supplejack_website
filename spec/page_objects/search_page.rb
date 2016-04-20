class SearchPage < LayoutPage
  set_url '/records{?query*}'
  section :search_panel, SearchPanelSection, '.search-panel'
end
