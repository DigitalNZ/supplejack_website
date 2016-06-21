require_relative 'search_panel_section'
require_relative 'search_category_section'
require_relative 'shared/layout_page'

class SearchPage < LayoutPage
  set_url '/records{?query*}'

  section :search_panel, SearchPanelSection, '.search-panel'
  # section :search_category, SearchCategorySection, 'ul:has(a.search-category-tab)'
  sections :search_category, SearchCategorySection, '.container[data-reactroot]'

  simple_element :search_input
  simple_element :search_button
  # simple_element :search_category_dropdon
  element :dropdown_category_btn, '.dropdown li a'
  elements :toplevel_category_btns, 'a.search-category-tab'
end
