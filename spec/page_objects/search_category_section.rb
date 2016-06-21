class SearchCategorySection < SitePrism::Section
	element :dropdown_button, '.dropdown li a'
	# elements :category_tabs, 'li:has(a.search-category-tab)'
end