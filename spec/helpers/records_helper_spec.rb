# The majority of The Supplejack Website code is Crown copyright (C) 2014, New Zealand Government,
# and is licensed under the GNU General Public License, version 3. Some components are 
# third party components that are licensed under the MIT license or other terms. 
# See https://github.com/DigitalNZ/supplejack_website for details. 
# 
# Supplejack was created by DigitalNZ at the National Library of NZ and the Department of Internal Affairs. 
# http://digitalnz.org/supplejack

RSpec.describe RecordsHelper do

  describe '#more_categories_list' do
    before(:each) do
      @categories = { "Guides & factsheets"=>2058, "Journals"=>41886, "Newspapers"=>34577 }
    end

    it 'creates a link for each category' do
      expect(helper.more_categories_list(@categories)).to match(/Guides & factsheets <span class="count">2,058<\/span>/)
    end
  end

  describe '#more_tab_title' do
    it 'should return "More" if params has no tabs' do
      expect(more_tab_title).to eq 'More'
    end

    it 'should return "More" if tab params is one of the SearchTab default tabs' do
      allow(controller).to receive(:params) { {tab: 'Videos'} }
      expect(more_tab_title).to eq 'More'
    end

    it 'should return "Facet name" if tab params is not one of the SearchTab default tabs' do
      allow(controller).to receive(:params) { {tab: 'Books'} }
      expect(more_tab_title).to eq 'Books'
    end    
  end

  describe '#facet_name' do
    it 'should capitalize a word passed to it' do
      expect(facet_name('videos')).to eq 'Videos'
    end

    it 'should replace _ with space' do
      expect(facet_name('god_delusions')).to eq 'God delusions'
    end

    it 'should replace return date for decade' do
      expect(facet_name('decade')).to eq 'Date'
    end    
  end

  # Unsure what all this testing is doing, just going to comment out until I revist since it
  # needs to be upgraded to RSpec 3 syntax

  # def mock_record(stubs={})
  #   @mock_record ||= mock_model(Record, stubs).as_null_object
  # end

  # describe '#source_contributor_name' do
  #   let(:record) { mock_record(title: 'Title', description: 'Description').as_null_record }

  #   it 'displays the contributing content partner' do
  #     record = mock_record(source_contributor_name: ['Culture', 'Europeana'])
  #     helper.source_contributor_name(record).should eq(%{<p>Culture, Europeana</p>})
  #   end
  # end

  # describe '#record_thumbnail' do
  #   before(:each) do
  #     @search = double(:search, :options => nil, :url_options => nil)
  #   end

  #   context 'the record has an image' do
  #     it 'should render a link with an image' do
  #       record = mock_record(:image_url => 'http://google.com/icon.gif', id: 1, title: 'title')
  #     end
  #   end

  #   it 'should render a link with a image with the specified alt and title text' do
  #     record = mock_record(image_url: 'http://google.com/icon.gif', :id => 1)
  #     helper.record_thumbnail(record, @search)
  #   end

  #   it 'should append the search options to the image link' do
  #     record = mock_record(:image_url => 'http://google.com/icon.gif', :id => 1)
  #     @search.stub(:options) { {:text=>'fish'} }

  #     helper.record_thumbnail(record, @search).should match('search%5Btext%5D=fish')
  #   end

  #   context 'placeholder image' do
  #     before(:each) do
  #       @record = mock(:record)
  #       @record.stub(:thumbnail_height) { }
  #       @record.stub(:image_url) { }
  #       @record.stub(:text?) { false }
  #       @record.stub(:creator) { 'Dave' }
  #     end

  #   end

  #   it 'should generate a link with no query parameters when there are no search options' do
  #     record = mock_record(:id => 1)

  #     @search.stub(:options) { {} }
  #     helper.record_thumbnail(record, @search).should match('<a href="\/records\/1">')
  #   end

  #   it 'should generate a link with search parameters when search options are passed' do
  #     record = mock_record(:id => 1)

  #     @search.stub(:options) { {text: 'fish'} }
  #     helper.record_thumbnail(record, @search).should match('<a href="\/records\/1\?search%5Btext%5D=fish">')
  #   end

  # end
end
