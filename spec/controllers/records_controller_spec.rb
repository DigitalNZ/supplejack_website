# The majority of The Supplejack Website code is Crown copyright (C) 2014, New Zealand Government,
# and is licensed under the GNU General Public License, version 3. Some components are 
# third party components that are licensed under the MIT license or other terms. 
# See https://github.com/DigitalNZ/supplejack_website for details. 
# 
# Supplejack was created by DigitalNZ at the National Library of NZ and the Department of Internal Affairs. 
# http://digitalnz.org/supplejack
RSpec.describe RecordsController do

  def mock_record(stubs={})
    @mock_record ||= mock_model(Record, stubs)
  end

  describe 'GET home' do
    let(:search) {instance_double(Search)}
    before(:each) {expect(Search).to receive(:new) { search }}

    it 'initializes a new search object' do
      get :home

      expect(assigns(:search)).to eq search
    end
  end

  describe 'GET index', :vcr do
    let(:search) {Search.new}
    before(:each) {expect(search).to receive(:results) { [mock_record] }}

    it 'should be successful' do
      pending("authenticate issue")
      expect(Search).to receive(:new) { search }

      get :index

      expect(response).to be_success
    end

    it 'should assign records as @records' do
      pending("authenticate issue")
      expect(Search).to receive(:new) { search }

      get :index

      expect(assigns(:records)).to be == [mock_record]
    end

    it 'should assign tab_counts' do
      pending("authenticate issue")
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

      expect(assigns(:record)).to be == mock_record 
    end
  end

  describe 'tab_counts' do
    it 'should remove the tab parameter from options' do
      expect(Search).to receive(:new).with({text: 'dog'}) { instance_double(Search, categories: {'All' => 20, 'Images' => 10, 'Sets' => 10 } ) }

      controller.send(:tab_counts, {text: 'dog', tab: 'sets'})
    end
  end
end
