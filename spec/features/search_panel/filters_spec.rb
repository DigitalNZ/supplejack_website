RSpec.feature 'A user interacts with the search panel filters', js: true, vcr: true do
  let(:kereru) {Kereru.new}
  let(:search_page) {kereru.search}
  let(:search_panel) {search_page.search_panel}

  before do
    search_page.load(query: {
      text: 'wellington',
      'i[primary_collection]' => '95bFM',
      # Addressable does not support array-like query params so will have to make do with a single 'or'
      'or[usage][]' => 'Modify',
    })
  end

  context 'applied filters' do
    scenario 'a user removes a filter' do
      search_panel.active_filters.first.click

      expect(search_panel.active_filters.length).to eq(1)
    end
  end
end
