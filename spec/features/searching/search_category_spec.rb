RSpec.feature 'A user performs a search with the search box', js: true, vcr: true, slow: true do
  let(:kereru) {Kereru.new}
  let(:search_page) {kereru.search}
  let(:search_category) {search_page.search_category}
  let(:search_term_literal) { 'Wellington' }
  let(:categories) {[ "#All-tab", "#Images-tab", "#Audio-tab", "#Videos-tab", "#Sets-tab" ]}

  context 'on the records index page' do
    before do
      search_page.load(query: {
        text: search_term_literal
      })
      search_page.wait_until_search_category_visible
    end

    feature "first-level search categories and dropdown menu title" do
      it "are shown with proper style" do
        expect(search_category).to have_toptier_category_btns, count: 5
        search_category.toptier_category_btns.each_with_index do | category_tab, idx |
          expect(category_tab).to have_css(categories[idx])
        end
        expect(search_category).to have_dropdown_button
      end
    end

    feature 'Search within a top-level categories' do
      context "the user select a category" do
        it 'performs a search with the selected top-level category and search term' do
          search_category.toptier_category_btns.last.click

          # Aync waiting for the completion of search
          expect(page).to have_current_path("/records?text=#{search_term_literal}&tab=Sets")
          
          query_hash = Rack::Utils.parse_nested_query(URI.parse(page.current_url).query)
          expect(query_hash.deep_symbolize_keys).to eq({
            text: search_term_literal,
            tab:  "Sets"
          })
        end
      end
    end

    feature 'Search within dropdown-level categories' do
      context "the user clicks the 'dropdown' button" do
        it 'dropdown menu items are displayed' do

          expect(search_category).to have_dropdown_button
          # trigger the dropdown menu button
          search_category.dropdown_button.click

          # Aync waiting until the dropdown categories come out
          expect(search_category).to have_extended_category_btns
          expect(search_category.extended_category_btns.count).to be > 1
        end
      end

      context "User clicks the 'dropdown' button and select a dropdown category" do
        it 'performs a search with the selected dropdown category and search term' do

          expect(search_category).to have_dropdown_button
          # trigger the dropdown menu button
          search_category.dropdown_button.click

          # Aync waiting until the dropdown menu items come out
          expect(search_category).to have_extended_category_btns
          # select the first dropdown category
          search_category.extended_category_btns.first.click

          expect(page).to have_current_path("/records?text=#{search_term_literal}&tab=Books")

          query_hash = Rack::Utils.parse_nested_query(URI.parse(page.current_url).query)
          expect(query_hash.deep_symbolize_keys).to eq({
            text: search_term_literal,          
            tab: "Books"
          })
        end
      end
    end
  end
end
