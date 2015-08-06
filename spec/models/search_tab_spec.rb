# The majority of The Supplejack Website code is Crown copyright (C) 2014, New Zealand Government,
# and is licensed under the GNU General Public License, version 3. Some components are 
# third party components that are licensed under the MIT license or other terms. 
# See https://github.com/DigitalNZ/supplejack_website for details. 
# 
# Supplejack was created by DigitalNZ at the National Library of NZ and the Department of Internal Affairs. 
# http://digitalnz.org/supplejack

require 'spec_helper'

describe SearchTab do

  let(:st) { SearchTab.new }
  
  describe 'initialize' do
    it 'assigns the tab' do
      SearchTab.new('images').tab.should eq 'images'
    end

    it 'defaults to all' do
      SearchTab.new(nil).tab.should eq 'All'
    end
  end

  describe 'valid_category_facets' do
    before(:each) do 
      @search = Search.new
      SearchTab.stub(:valid_category_facets) { ['Images']}
    end

    it 'gets the valid category facets' do
      SearchTab.should_receive(:valid_category_facets)
      SearchTab.add_category_facets(@search, 'Images')
    end 

    context 'valid category' do
      it 'adds the category to the search' do
        SearchTab.add_category_facets(@search, 'Images')
        @search.and[:category].should eq 'Images'
      end
    end

    context 'invalid category' do
      it 'doesn\'t add invalid categories to the search' do
        SearchTab.add_category_facets(@search, 'INVALID')
        @search.and[:INVALID].should eq nil
      end
    end
  end

  describe 'valid_category_facets' do
    let(:search) { double('search', :facet_values => {}) }
    
    it 'returns the valid type facets' do
      Search.stub(:new) { search }
      search.should_receive(:facet_values).with('category')
      SearchTab.valid_category_facets
    end
  end

  describe 'sorted counts' do
    let(:unsorted_counts) { { 'Newspapers'=>1346566, 'Images'=>1056473, 'Journals'=>39515, 'Videos'=>7655, 'Audio'=>2553, 'All'=>2448694 } }
    
    it 'returns five categories' do
      SearchTab.sorted_counts(unsorted_counts).count.should eq 5
    end

    it 'sorts by count' do
      SearchTab.sorted_counts(unsorted_counts).shift.should eq ['All', 2448694]
    end
  end

  describe 'tab_label' do
    it 'creates label html with given values' do
      SearchTab.tab_label('images', '1,234').should eq(%{Images <span class="count">1,234</span>})
    end
  end

  describe 'all?' do
    it 'returns true' do
      st.stub(:tab) { 'All' }
      expect(st.all?).to be true
    end

    it 'returns true' do
      st = SearchTab.new('')
      expect(st.all?).to be true
    end

    it 'returns false' do
      st.stub(:tab) { 'Images' }
      expect(st.all?).to be false
    end
  end

  describe 'value' do
    it 'returns the value if view is present' do
      st.instance_variable_set(:@tab, 'sets')
      st.value.should eq('sets')
    end

    it 'returns nil if view is not present' do
      st.instance_variable_set(:@tab, nil)
      st.value.should be_nil
    end
  end
end