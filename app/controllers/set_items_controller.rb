# frozen_string_literal: true

class SetItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    success = false

    if params[:user_set_id].present? && params[:user_set_item].present?
      user_set = current_sj_user.sets.find(params[:user_set_id])
      set_item = user_set.items.build(set_items_params[:user_set_item].to_h)
      success = set_item.save
    end

    render success ? { plain: "OK", status: 200 } : { plain: "OK", status: 500 }
  end

  private

  def set_items_params
    params.require(:user_set_id)
    params.require(:user_set_item)
    params.permit(:user_set_id, user_set_item: [:record_id])
  end
end
