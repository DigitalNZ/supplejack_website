# The majority of The Supplejack Website code is Crown copyright (C) 2014, New Zealand Government,
# and is licensed under the GNU General Public License, version 3. Some components are 
# third party components that are licensed under the MIT license or other terms. 
# See https://github.com/DigitalNZ/supplejack_website for details. 
# 
# Supplejack was created by DigitalNZ at the National Library of NZ and the Department of Internal Affairs. 
# http://digitalnz.org/supplejack

class UserSetsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  
  def show
    @user_set = Supplejack::UserSet.find(params[:id])
    @records = @user_set.items
    @search = search(params[:search])
  end

  def create
    @user_set = current_sj_user.sets.build(params[:user_set])
    @user_set.records = [{record_id: params[:record_id]}] if params[:record_id]
    @user_set.save
    @user_sets = current_user.sets.all

    redirect_to user_sets_path
  end
end
