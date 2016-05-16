class SearchPage < LayoutPage
  set_url '/records{?query*}'

  section :search_panel, SearchPanelSection, '.search-panel'

  simple_element :search_input
  simple_element :search_button
end
