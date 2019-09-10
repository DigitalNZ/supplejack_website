require 'rails_helper'

RSpec.describe RecordsController do

  # def mock_record(stubs={})
  #   @mock_record ||= mock_model(Record, stubs).as_null_object
  # end

  describe 'GET home' do
    it 'initializes a new search object' do
      get :home
      expect(assigns(:search)).to eq(Search.new)
    end
  end

  describe 'GET index', :vcr do
    before(:each) do
      @search = Search.new
      @search.stub(:results) { [mock_record] }
    end

    it 'should be successful' do
      Search.stub(:new) { @search }
      get :index
      response.should be_success
    end

    it 'should assign records as @records' do
      Search.stub(:new) { @search }
      get :index
      assigns(:records).should == [mock_record]
    end

    it 'should assign tab_counts' do
      controller.should_receive(:tab_counts).and_return('images' => 16)
      get :index
      assigns(:counts).should eq({'images' => 16})
    end
  end

  describe 'GET show' do
    before(:each) do
      mock_record.stub(:attributes) { {format: 'images'} }
      Record.stub(:find) { mock_record }
    end

    it 'should be successful' do
      get :show, id: 1
      response.should be_success
    end

    it 'finds the record and passes any search params' do
      Record.should_receive(:find).with('1', {'i' => {'type' => 'Images'}, 'or' => {}})
      get :show, :id => '1', :search => {'i' => {'type' => 'Images'}}
      assigns(:record).should == mock_record
    end
  end

  describe 'tab_counts' do
    it 'should remove the tab parameter from options' do
      Search.should_receive(:new).with({text: 'dog'}) { double(:search, categories: {'All' => 20, 'Images' => 10, 'Sets' => 10 } ) }
      controller.send(:tab_counts, {text: 'dog', tab: 'sets'})
    end

    it 'should merge the text attribute from the main search to the tab count search' do
      Search.should_receive(:new).with({text: 'dog'}) { double(:search, categories: {'All' => 20, 'Images' => 10, 'Sets' => 10 } ) }
      controller.send(:tab_counts, {text: 'dog', tab: 'sets'})
    end
  end
end
