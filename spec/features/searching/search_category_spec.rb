RSpec.feature 'A user performs a search with the search box', js: true, vcr: true, slow: true do
  let(:kereru) {Kereru.new}
  let(:search_page) {kereru.search}
  let(:search_category) {search_page.search_category}
  let(:search_term_literal) { 'Wellington' }

  context 'on the records index page' do
    before do
      search_page.load(query: {
        text: search_term_literal
      })
    end

    feature 'Search within a category by clicking toplevel categories' do
      context "the user clicks the 'Search' button" do
        it 'performs a search with the users entered input' do

          search_page.wait_until_search_category_visible
          expect(search_category).to have_dropdown_button

          search_category.dropdown_button.click
          expect(page).to have_current_path("/records?text=#{search_term_literal}")     
          
          query_hash = Rack::Utils.parse_nested_query(URI.parse(page.current_url).query)
          expect(query_hash.deep_symbolize_keys).to eq({
            text: search_term_literal,
          })
        end
      end
    end

    feature 'Search within a category by clicking dropdown-level categories' do
      context "the user clicks the 'Search' button" do
        it 'performs a search with the users entered input' do

          search_page.wait_until_search_category_visible
          expect(search_category).to have_dropdown_button

          # trigger the dropdown menu button
          search_category.dropdown_button.click
          pwork = Capybara.current_session
            
          # wait until the dropdown menu items come out
          expect(search_category).to have_extended_category_btns

          # select the first dropdown menu items
          search_category.extended_category_btns[0].click
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
