require 'rails_helper'

RSpec.describe SearchTab do
  describe 'initialize' do
    it 'assigns the tab' do
      expect(SearchTab.new('images').tab).to eq('images')
    end

    it 'defaults to all' do
      expect(SearchTab.new(nil).tab).to eq('All')
    end
  end

  describe 'valid_category_facets' do
    let (:search) { Search.new }
    before(:each) do
      allow(SearchTab).to receive(:valid_category_facets).and_return(['Images'])
    end

    it 'gets the valid category facets' do
      expect(SearchTab).to receive(:valid_category_facets)
      SearchTab.add_category_facets(search, 'Images')
    end

    context 'valid category' do
      it 'adds the category to the search' do
        SearchTab.add_category_facets(search, 'Images')
        expect(search.and[:category]).to eq('Images')
      end
    end

    context 'invalid category' do
      it 'doesn\'t add invalid categories to the search' do
        SearchTab.add_category_facets(search, 'INVALID')
        expect(search.and[:INVALID]).to be_nil
      end
    end
  end

  describe 'valid_category_facets' do
    it 'returns the valid type facets' do
      expect_any_instance_of(Search).to receive(:facet_values).with('category').and_call_original
      SearchTab.valid_category_facets
    end
  end

  describe 'sorted counts' do
    let(:unsorted_counts) {{
        'Newspapers' => 1346566,
        'Images' => 1056473,
        'Journals' => 39515,
        'Videos' => 7655,
        'Audio' => 2553,
        'All' => 2448694
    }}

    it 'returns five categories' do
      expect(SearchTab.sorted_counts(unsorted_counts).count).to eq 5
    end

    it 'sorts by count' do
      expect(SearchTab.sorted_counts(unsorted_counts).shift).to eq ['All', 2448694]
    end
  end

  describe 'tab_label' do
    it 'creates label html with given values' do
      expect(SearchTab.tab_label('images', '1,234')).to eq('Images <span class="count">1,234</span>')
    end
  end

  describe 'all?' do
    it 'returns true when initialized with no parameter' do
      expect(SearchTab.new.all?).to be true
    end

    it 'returns true when initialized with an empty string' do
      expect(SearchTab.new('').all?).to be true
    end

    it 'returns false when initialized with "Images"' do
      expect(SearchTab.new('Images').all?).to be false
    end
  end

  describe 'value' do
    it 'returns the value if view is present' do
      # search_tab.instance_variable_set(:@tab, 'sets')
      expect(SearchTab.new('sets').value).to eq('sets')
    end
  end
end
