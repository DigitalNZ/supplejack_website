class CommunitiesController < ApplicationController
  before_action :set_community, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @communities = Community.order(:name)
    respond_with(@communities)
  end

  def show
    @breadcrumbs = [
      ['Communities', communities_path],
      [@community, @community],
    ]
    @contributed_item = ContributedItem.new
    @feature_story = @community.stories.first
    if @community.name == 'Tauranga'
      cp = 'Tauranga City Libraries'
    else
      cp = @community.kete_slug
    end
    @counts = SearchTab.sorted_counts( tab_counts( { i: { content_partner: cp } } ) )
    @search = Search.new( i: { content_partner: cp } )
    SearchTab.add_category_facets(@search, 'Images')
    respond_with(@community)
  end

  def new
    @community = Community.new
    respond_with(@community)
  end

  def edit
  end

  def create
    @community = Community.new(community_params)
    @community.save
    respond_with(@community)
  end

  def update
    @community.update(community_params)
    respond_with(@community)
  end

  def destroy
    @community.destroy
    respond_with(@community)
  end

  private
    def set_community
      @community = Community.find_by_slug(params[:id])
    end

    def community_params
      params.require(:community).permit(:name, :slug, :description)
    end

    #FIXME: Copied quickly from RecordsController; needs DRYing
    def tab_counts(options = {})
      options.delete(:tab)
      counts_search = Search.new(options)
      Hash.new(0).merge(counts_search.categories) rescue {}
    end


end
