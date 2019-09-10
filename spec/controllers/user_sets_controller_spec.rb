# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserSetsController do
  describe 'GET show' do
    let(:set) do
      instance_double(
        'Supplejack::UserSet', items: [
          FactoryBot.build(:record),
          FactoryBot.build(:record)
        ]
      )
    end

    before do
      allow(Supplejack::UserSet).to receive(:find) { set }

      get :show, params: { id: '' }
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
