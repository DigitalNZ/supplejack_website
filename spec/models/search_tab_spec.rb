# The majority of The Supplejack Website code is Crown copyright (C) 2014, New Zealand Government,
# and is licensed under the GNU General Public License, version 3. Some components are
# third party components that are licensed under the MIT license or other terms.
# See https://github.com/DigitalNZ/supplejack_website for details.
#
# Supplejack was created by DigitalNZ at the National Library of NZ and the Department of Internal Affairs.
# http://digitalnz.org/supplejack

RSpec.describe SearchTab do

  let(:st) { described_class.new }

  describe 'initialize' do
    it 'assigns the tab' do
      expect(described_class.new('images').tab).to eq 'images'
    end

    it 'defaults to all' do
      expect(described_class.new(nil).tab).to eq 'All'
    end
  end

  describe 'valid_category_facets' do
    let(:search) {Search.new}
    before(:each) {allow(described_class).to receive(:valid_category_facets) { ['Images']}}

    context 'valid category' do
      it 'adds the category to the search' do
        described_class.add_category_facets(search, 'Images')
        expect(search.and[:category]).to eq 'Images'
      end
    end

    context 'invalid category' do
      it 'doesn\'t add invalid categories to the search' do
        described_class.add_category_facets(search, 'INVALID')
        expect(search.and[:INVALID]).to eq nil
      end
    end
  end

  describe 'valid_category_facets' do
    let(:search) { instance_double('Search', :facet_values => {}) }

    it 'returns the valid type facets' do
      expect(Search).to receive(:new).and_return(search)
      expect(search).to receive(:facet_values).with('category')

      described_class.valid_category_facets
    end
  end

  describe 'sorted counts' do
    let(:unsorted_counts) do
      {
        'Newspapers' => 1346566,
        'Images' => 1056473,
        'Journals' => 39515,
        'Videos' => 7655,
        'Audio' => 2553,
        'All' => 2448694
      }
    end

    it 'returns five categories' do
      expect(described_class.sorted_counts(unsorted_counts).count).to eq 5
    end

    it 'sorts by count' do
      expect(described_class.sorted_counts(unsorted_counts).shift).to eq ['All', 2448694]
    end
  end

  describe 'more_categories_sum' do
    let(:random_category_counts) do
      {
       "Manuscripts": 3133,
       "Other": 1227,
       "Videos": 284,
       "Data": 278,
       "Audio": 159
     }
    end

    it 'returns one number about the sum of all records belonging to dropdown menu' do
      expect(described_class.more_categories_sum(random_category_counts).count).to eq 1
    end

    it 'returns the correct sumup of all records belonging to dropdown menu' do
      expect(described_class.more_categories_sum(random_category_counts).values.first).to eq 4638
    end
  end

  describe 'tab_label' do
    it 'creates label html with given values' do
      expect(described_class.tab_label('images', '1,234')).to eq(%{Images <span class="count">1,234</span>})
    end
  end

  describe 'all?' do
    it 'returns true' do
      allow(st).to receive(:tab) { 'All' }
      expect(st.all?).to be true
    end

    it 'returns true' do
      st = described_class.new('')
      expect(st.all?).to be true
    end

    it 'returns false' do
      allow(st).to receive(:tab) { 'Images' }
      expect(st.all?).to be false
    end
  end

  describe 'value' do
    it 'returns the value if view is present' do
      st.instance_variable_set(:@tab, 'sets')
      expect(st.value).to eq('sets')
    end

    it 'returns nil if view is not present' do
      st.instance_variable_set(:@tab, nil)
      expect(st.value).to be_nil
    end
  end

  describe "value" do
    it "returns the value if view is present" do
      st.instance_variable_set(:@tab, "sets")
      expect(st.value).to eq("sets")
    end

    it "returns nil if view is not present" do
      st.instance_variable_set(:@tab, nil)
      expect(st.value).to be_nil
    end
  end
end
