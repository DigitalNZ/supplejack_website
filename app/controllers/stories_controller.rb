class StoriesController < ApplicationController
  before_action :set_story, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @stories = Story.all
    respond_with(@stories)
  end

  def show
    @records  = @story.user_set.items
    @search   = search(params[:search])
    @contributed_item = ContributedItem.new
    @community = @story.communities.first
    @breadcrumbs = [
      ['Communities', communities_path],
      [@community, @community],
      [@story, @story],
    ]

    respond_with(@story)
  end

  def new
    @story = Story.new
    respond_with(@story)
  end

  def edit
  end

  def create
    @story = Story.new(story_params)
    @story.save
    respond_with(@story)
  end

  def update
    @story    = Story.find_by(user_set_id: params[:id])
    if @story.update(params.permit(:content))
      render :json => { :status => 'ok' }
    else
      render :json => { :status => '500' }
    end
  end

  def destroy
    @story.destroy
    respond_with(@story)
  end

  private
    def set_story
      # FIXME: Naive implementation, will create bad ids!
      @story = Story.find_or_create_by(user_set_id: params[:id])
    end

    def story_params
      params.require(:story).permit(:user_set_id, :content)
    end
end
