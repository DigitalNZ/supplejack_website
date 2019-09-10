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
      allow(@search).to receive(:results) { [mock_record] }
    end

    it 'should be successful' do
      allow(Search).to receive(:new) { @search }
      get :index
      expect(response).to be_success
    end

    it 'should assign records as @records' do
      allow(Search).to receive(:new) { @search }
      get :index
      expect(assigns(:records)).to eq([mock_record])
    end

    it 'should assign tab_counts' do
      expect(controller).to receive(:tab_counts).and_return('images' => 16)
      get :index
      expect(assigns(:counts)).to eq({'images' => 16})
    end
  end

  describe 'GET show' do
    before(:each) do
      allow(mock_record).to receive(:attributes) { {format: 'images'} }
      allow(Record).to receive(:find) { mock_record }
    end

    it 'should be successful' do
      get :show, id: 1
      expect(response).to be_success
    end

    it 'finds the record and passes any search params' do
      expect(Record).to receive(:find).with('1', {'i' => {'type' => 'Images'}, 'or' => {}})
      get :show, :id => '1', :search => {'i' => {'type' => 'Images'}}
      expect(assigns(:record)).to eq(mock_record)
    end
  end

  describe 'tab_counts' do
    it 'should remove the tab parameter from options' do
      expect(Search).to receive(:new).with({text: 'dog'}) { double(:search, categories: {'All' => 20, 'Images' => 10, 'Sets' => 10 } ) }
      controller.send(:tab_counts, {text: 'dog', tab: 'sets'})
    end

    it 'should merge the text attribute from the main search to the tab count search' do
      expect(Search).to receive(:new).with({text: 'dog'}) { double(:search, categories: {'All' => 20, 'Images' => 10, 'Sets' => 10 } ) }
      controller.send(:tab_counts, {text: 'dog', tab: 'sets'})
    end
  end
end
