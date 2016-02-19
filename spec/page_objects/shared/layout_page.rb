require_relative 'menu_section'

class LayoutPage < SitePrism::Page
  section :menu, MenuSection, "nav[role=navigation]"
end
