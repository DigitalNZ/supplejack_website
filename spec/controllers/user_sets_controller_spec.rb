# The majority of The Supplejack Website code is Crown copyright (C) 2014, New Zealand Government,
# and is licensed under the GNU General Public License, version 3. Some components are 
# third party components that are licensed under the MIT license or other terms. 
# See https://github.com/DigitalNZ/supplejack_website for details. 
# 
# Supplejack was created by DigitalNZ at the National Library of NZ and the Department of Internal Affairs. 
# http://digitalnz.org/supplejack

RSpec.describe UserSetsController do
  describe 'GET show' do
    let(:set) do
      double(:set, {
        items: [
          double(:record),
          double(:record)
        ]
      })
    end
    let(:set_id) {'1'}

    before do
      expect(Supplejack::UserSet).to receive(:find).with(set_id).and_return(set)

      get :show, id: set_id
    end

    it "assigns @user_set to the correct UserSet" do
      expect(assigns(:user_set)).to eq(set)
    end
    
    it 'assigns @records to the sets items' do
      expect(assigns(:records)).to eq(set.items)
    end
  end

  describe 'GET index' do
    login_user

    it "retrieves the sets from the current_sj_user" do
      dummy_sj_user = instance_double(Supplejack::User)
      
      expect(controller).to receive(:current_sj_user).and_return(dummy_sj_user)
      expect(dummy_sj_user).to receive(:sets).and_return(
        [double(name: 'test', id: 1, count: 1)]
      )

      get :index
    end
  end

  describe 'POST create' do
    login_user

    context 'valid params' do
      let(:user_set_params) {{'foo' => 'bar'}}
      let(:set_double) {double(:set).as_null_object}
      let(:sj_user) {instance_double(Supplejack::User, sets: set_double)}

      before {expect(controller).to receive(:current_sj_user).and_return(sj_user)}

      it 'builds a new set under the current_sj_user with supplied params' do
        expect(sj_user.sets).to receive(:build).with(user_set_params).and_return(set_double)

        post :create, user_set: user_set_params
      end

      it 'add the record to the user_set records if a :record_id id param is provided' do
        expect(sj_user.sets).to receive(:build).with(user_set_params).and_return(set_double)
        expect(set_double).to receive(:records=)

        post :create, user_set: user_set_params, record_id: 1
      end
    end

    context 'invalid params' do
      it 'returns a 500 error if there is no user_set param provided' do
        post :create

        expect(response.status).to eq(500)
      end
    end
  end
end
