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

    it 'is successful' do
      skip("authenticate issue")
      expect(Search).to receive(:new) { search }

      get :index

      expect(response).to be_success
    end

    it 'assigns records as @records' do
      skip("authenticate issue")
      expect(Search).to receive(:new) { search }

      get :index

      expect(assigns(:records)).to be == [mock_record]
    end

    it 'assigns tab_counts' do
      skip("authenticate issue")
      expect(controller).to receive(:tab_counts).and_return('images' => 16)

      get :index

      expect(assigns(:counts)).to eq({'images' => 16})
    end
  end

  describe 'GET show' do
    it "finds the correct record" do
      id = "123"
      search = {foo: "123"}

      expect(Record).to receive(:find).with(id, search).and_return(nil)

      get :show, id: id, search: search
    end

    context "user set" do
      let(:user_set_id) {'123'}
      let(:record) {Record.new(category: ['Sets'], landing_url: "foo/#{user_set_id}")}
      before {expect(Record).to receive(:find).and_return(record)}

      it "redirects you to the user_set show path" do
        get :show, id: 1

        expect(controller).to redirect_to(user_set_path(user_set_id))
      end

      it "adds :record_id to the search attribute if the search param is set" do
        get :show, id: 1, search: {}

        expect(controller).to redirect_to(user_set_path(user_set_id, search: {record_id: 1}))
      end
    end
  end

  describe 'tab_counts' do
    it 'removes the tab parameter from options' do
      expect(Search).to receive(:new).with({text: 'dog'}) do
        instance_double(Search, categories: {'All' => 20, 'Images' => 10, 'Sets' => 10 } ) 
      end

      controller.send(:tab_counts, {text: 'dog', tab: 'sets'})
    end
  end
end
