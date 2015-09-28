# The majority of The Supplejack Website code is Crown copyright (C) 2014, New Zealand Government,
# and is licensed under the GNU General Public License, version 3. Some components are 
# third party components that are licensed under the MIT license or other terms. 
# See https://github.com/DigitalNZ/supplejack_website for details. 
# 
# Supplejack was created by DigitalNZ at the National Library of NZ and the Department of Internal Affairs. 
# http://digitalnz.org/supplejack

require 'spec_helper'

describe RecordsHelper do
  def mock_record(stubs={})
    @mock_record ||= mock_model(Record, stubs).as_null_object
  end

  describe '#source_contributor_name' do
    let(:record) { mock_record(title: 'Title', description: 'Description').as_null_record }

    it 'displays the contributing content partner' do
      record = mock_record(source_contributor_name: ['Culture', 'Europeana'])
      helper.source_contributor_name(record).should eq(%{<p>Culture, Europeana</p>})
    end
  end

  describe '#record_thumbnail' do
    before(:each) do
      @search = double(:search, :options => nil, :url_options => nil)
    end

    context 'the record has an image' do
      it 'should render a link with an image' do
        record = mock_record(:image_url => 'http://google.com/icon.gif', id: 1, title: 'title')
        helper.record_thumbnail(record, @search).should eq(%{<div>#{link_to image_tag("http://google.com/icon.gif", :alt => "title", :title => "title"), "/records/1"}</div>})
      end
    end

    it 'should render a link with a image with the specified alt and title text' do
      record = mock_record(image_url: 'http://google.com/icon.gif', :id => 1)
      helper.record_thumbnail(record, @search)
    end

    it 'should append the search options to the image link' do
      record = mock_record(:image_url => 'http://google.com/icon.gif', :id => 1)
      @search.stub(:options) { {:text=>'fish'} }

      helper.record_thumbnail(record, @search).should match('search%5Btext%5D=fish')
    end

    context 'placeholder image' do
      before(:each) do
        @record = mock(:record)
        @record.stub(:thumbnail_height) { }
        @record.stub(:image_url) { }
        @record.stub(:text?) { false }
        @record.stub(:creator) { 'Dave' }
      end

    end

    it 'should generate a link with no query parameters when there are no search options' do
      record = mock_record(:id => 1)

      @search.stub(:options) { {} }
      helper.record_thumbnail(record, @search).should match('<a href="\/records\/1">')
    end

    it 'should generate a link with search parameters when search options are passed' do
      record = mock_record(:id => 1)

      @search.stub(:options) { {text: 'fish'} }
      helper.record_thumbnail(record, @search).should match('<a href="\/records\/1\?search%5Btext%5D=fish">')
    end

    context '#date_parser_for' do
      it "should return the same string if its not a date" do
        helper.date_parser_for("not a date string").should eq "not a date string"
      end

      it "should return date formated string" do
        helper.date_parser_for("05-02-1986").should eq "05 Feb 1986"
      end
    end

  end
end
