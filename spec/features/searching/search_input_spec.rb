RSpec.feature 'A user performs a search with the search box', js: true, vcr: true, slow: true do
  let(:kereru) {Kereru.new}
  let(:search_page) {kereru.search}
  let(:home_page) {kereru.home}

  context 'on the records index page' do
    before {search_page.load}

    feature 'Performing a search' do
      context "the user clicks the 'Search' button" do
        it 'performs a search with the users entered input' do
          search_page.search_input.set 'Wellington'
          search_page.search_button.click

          # :( capybara doesn't appear to have support for waiting for the URL to change
          sleep 5

          query_hash = Rack::Utils.parse_nested_query(URI.parse(page.current_url).query)
          expect(query_hash.deep_symbolize_keys).to eq({
            text: 'Wellington'
          })
        end
      end
    end
  end

  context 'on the records home page' do
    before {home_page.load}

    feature 'Performing a search' do
      context "the user clicks the 'Search' button" do
        it 'performs a search with the users entered input' do
          home_page.search_input.set 'Wellington'
          home_page.search_button.click

          # :( capybara doesn't appear to have support for waiting for the URL to change
          sleep 5

          query_hash = Rack::Utils.parse_nested_query(URI.parse(page.current_url).query)
          expect(query_hash.deep_symbolize_keys).to eq({
            text: 'Wellington',
            tab: ''
          })
        end
      end
    end
  end
end
