class SearchCategorySection < SitePrism::Section
	element :dropdown_button, '#more-dropdown-menu>a'
  	elements :toptier_category_btns, '#search-category-menu>ul>li'
	elements :extended_category_btns, '#more-drop>li>a'
end