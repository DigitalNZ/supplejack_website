class ContributedItemsController < ApplicationController
  before_action :set_contributed_item, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @contributed_items = ContributedItem.all
    respond_with(@contributed_items)
  end

  def show
    respond_with(@contributed_item)
  end

  def new
    @contributed_item = ContributedItem.new
    respond_with(@contributed_item)
  end

  def edit
  end

  def create
    @contributed_item = ContributedItem.new(contributed_item_params)
    @contributed_item.save
    respond_with(@contributed_item)
  end

  def update
    @contributed_item.update(contributed_item_params)
    respond_with(@contributed_item)
  end

  def destroy
    @contributed_item.destroy
    respond_with(@contributed_item)
  end

  private
    def set_contributed_item
      @contributed_item = ContributedItem.find(params[:id])
    end

    def contributed_item_params
      params.require(:contributed_item).permit(:category, :name, :status, :description, :date_of_item, :creator, :copyright, :item_path, :user_id)
    end
end
