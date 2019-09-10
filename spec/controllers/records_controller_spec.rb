require 'rails_helper'

RSpec.describe RecordsController do
  describe 'GET home' do
    it 'initializes a new search object' do
      get :home
      expect(assigns(:search)).to be_a(Search)
    end
  end

  describe 'GET index', :vcr do
    before(:each) do
      search = Search.new
      allow(search).to receive(:results) { [mock_record] }
    end

    it 'should be successful' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'should assign records as @records' do
      get :index
      expect(assigns(:records)).to be_a(Array)
    end

    it 'should assign tab_counts' do
      expect(controller).to receive(:tab_counts).and_return('images' => 16)
      get :index
      expect(assigns(:counts)).to eq({'images' => 16})
    end
  end

  describe 'GET show', :vcr do
    it 'should be successful' do
      get :show, params: { id: 34870516 }
      expect(response).to have_http_status(:success)
    end

    it 'finds the record and passes any search params' do
      get :show, params: { id: 34870516, search: { i: { type: 'Images' } } }
      expect(assigns(:record)).to be_a(Record)
    end
  end
end
