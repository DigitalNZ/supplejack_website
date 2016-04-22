RSpec.feature 'A user interacts with the search panel filters', js: true, vcr: true, slow: true do
  let(:kereru) {Kereru.new}
  let(:search_page) {kereru.search}
  let(:search_panel) {search_page.search_panel}

  before do
    search_page.load(query: {
      text: 'wellington',
      'i[primary_collection]' => 'TAPUHI',
      # Addressable does not support array-like query params so will have to make do with a single 'or'
      'or[usage][]' => 'Modify'
    })
  end

  feature 'Removing active filters' do
    context 'a user removes a filter' do
      it 'is removed from the page' do
        search_panel.active_filters.first.click

        expect(search_panel.active_filters.length).to eq(1)
      end
    end
  end

  feature 'Adding new filters' do
    context 'a user adds a new filter' do
      background do
        search_panel.panel_toggle.click
        search_panel.usage_tab.click
        search_panel.active_tab_elements.first.click
      end

      it 'is added to the page' do
        expect(search_panel.active_filters.length).to eq(3)
      end

      it "changes the text of the 'Close' button to 'Apply'" do
        expect(search_panel.close_button).to have_text('Apply')
      end
    end
  end

  feature 'Toggling the search panel' do
    background do
      search_panel.panel_toggle.click
    end

    context "a user clicks the 'Filters' button" do
      it 'opens the panel if it is closed' do
        expect(search_panel.panel).to be_visible
      end

      it 'closes the panel if it is open' do
        search_panel.panel_toggle.click

        expect(search_panel).to have_no_panel
      end
    end

    context "a user clicks the 'Close' button" do
      it 'closes the panel' do
        search_panel.close_button.click

        expect(search_panel).to have_no_panel
      end
    end
  end

  feature 'Performing a search', focus: true do
    it 'loads the search page with the filters applied' do
      search_panel.panel_toggle.click
      search_panel.usage_tab.click
      search_panel.active_tab_elements.last.click
      binding.pry
      search_panel.close_button.click
     
      # :(
      sleep 5

      query_hash = Rack::Utils.parse_nested_query(URI.parse(page.current_url).query)
      binding.pry
      expect(query_hash.deep_symbolize_keys).to eq({
        text: 'wellington',
        i: {
          primary_collection: 'TAPUHI',
        },
        or: {
          usage: ['Modify', 'Use commercially']
        }
      })
    end
  end
end
