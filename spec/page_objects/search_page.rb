require_relative 'search_panel_section'
require_relative 'search_category_section'
require_relative 'shared/layout_page'

class SearchPage < LayoutPage
  set_url '/records{?query*}'

  section :search_panel, SearchPanelSection, '.search-panel'
  section :search_category, SearchCategorySection, '#search-category-menu'

  simple_element :search_input
  simple_element :search_button
end