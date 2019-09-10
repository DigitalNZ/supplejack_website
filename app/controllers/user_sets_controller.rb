# frozen_string_literal: true

class UserSetsController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def show
    @user_set = Supplejack::UserSet.find(params[:id])
    @records = @user_set.items
    @search = search(params[:search])
  end

  def index
    sets = current_sj_user.sets.map do |set|
      { name: set.name, id: set.id, items_count: set.count }
    end

    respond_to do |format|
      format.js do
        render json: { sets: sets }
      end
    end
  end

  def create
    render nothing: true, status: 500 if params[:user_set].nil?

    user_set = current_sj_user.sets.build(params[:user_set])
    user_set.records = [{ record_id: params[:record_id] }] if params[:record_id]
    user_set.save

    respond_to do |format|
      format.html { redirect_to user_sets_path }
      format.js do
        render json: { set_id: user_set.id }.to_json
      end
    end
  end
end
