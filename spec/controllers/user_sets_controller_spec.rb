require 'rails_helper'

RSpec.describe UserSetsController do
  describe 'GET show' do
    let(:set) {
      double(:set, {
        items: [
          double(:record),
          double(:record)
        ]
      })
    }
    before do
      allow(Supplejack::UserSet).to receive(:find) {set}

      get :show, id: ''
    end

    it 'assigns @user_set to the set' do
      expect(assigns(:user_set)).to eq(set)
    end

    it 'assigns @records to the sets items' do

      expect(assigns(:records)).to eq(set.items)
    end

    it 'assigns @search to a new search' do
      expect(assigns(:search)).to eq(controller.search(nil))
    end
  end
end
