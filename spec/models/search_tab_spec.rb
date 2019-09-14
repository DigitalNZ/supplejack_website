# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchTab do
  describe '#initialize' do
    it 'assigns the tab' do
      expect(described_class.new('images').tab).to eq('images')
    end

    it 'defaults to all' do
      expect(described_class.new(nil).tab).to eq('All')
    end
  end

  describe '#valid_category_facets' do
    let(:search) { Search.new }

    before do
      allow(described_class).to receive(:valid_category_facets).and_return(['Images'])
    end

    it 'gets the valid category facets' do
      expect(described_class).to receive(:valid_category_facets)
      described_class.add_category_facets(search, 'Images')
    end

    context 'with a valid category' do
      it 'adds the category to the search' do
        described_class.add_category_facets(search, 'Images')
        expect(search.and[:category]).to eq('Images')
      end
    end

    context 'with an invalid category' do
      it 'doesn\'t add invalid categories to the search' do
        described_class.add_category_facets(search, 'INVALID')
        expect(search.and[:INVALID]).to be_nil
      end
    end
  end

  describe '#sorted_counts' do
    let(:unsorted_counts) do
      {
        'Newspapers' => 1_346_566,
        'Images' => 1_056_473,
        'Journals' => 39_515,
        'Videos' => 7655,
        'Audio' => 2553,
        'All' => 2_448_694
      }
    end

    it 'returns five categories' do
      expect(described_class.sorted_counts(unsorted_counts).count).to eq 5
    end

    it 'sorts by count' do
      expect(described_class.sorted_counts(unsorted_counts).shift).to eq ['All', 2_448_694]
    end
  end

  describe '#tab_label' do
    it 'creates label html with given values' do
      expect(described_class.tab_label('images', '1,234')).to eq('Images <span class="count">1,234</span>')
    end
  end

  describe '#all?' do
    it 'returns true when initialized with no parameter' do
      expect(described_class.new.all?).to be true
    end

    it 'returns true when initialized with an empty string' do
      expect(described_class.new('').all?).to be true
    end

    it 'returns false when initialized with "Images"' do
      expect(described_class.new('Images').all?).to be false
    end
  end

  describe '#value' do
    it 'returns the value if view is present' do
      # search_tab.instance_variable_set(:@tab, 'sets')
      expect(described_class.new('sets').value).to eq('sets')
    end
  end
end
