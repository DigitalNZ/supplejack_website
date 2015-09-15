# The majority of The Supplejack Website code is Crown copyright (C) 2014, New Zealand Government,
# and is licensed under the GNU General Public License, version 3. Some components are 
# third party components that are licensed under the MIT license or other terms. 
# See https://github.com/DigitalNZ/supplejack_website for details. 
# 
# Supplejack was created by DigitalNZ at the National Library of NZ and the Department of Internal Affairs. 
# http://digitalnz.org/supplejack

require 'spec_helper'

describe UserSetsController do
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
      Supplejack::UserSet.stub(:find) {set}

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
