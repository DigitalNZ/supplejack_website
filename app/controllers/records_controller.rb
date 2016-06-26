# The majority of The Supplejack Website code is Crown copyright (C) 2014,
# New Zealand Government, and is licensed under the GNU General Public License,
# version 3. Some components are third party components that are licensed under
# the MIT license or other terms.
# See https://github.com/DigitalNZ/supplejack_website for details.
#
# Supplejack was created by DigitalNZ at the National Library of NZ and
# the Department of Internal Affairs.
# http://digitalnz.org/supplejack

# Records controller deals with searching and displaying records
class RecordsController < ApplicationController
  include ReactOnRails::Controller

  def home
  end

  # Provide all the subjects for search results page
  #
  # @Author: Taylor
  # @last modified Jeffery
  # @param params(key :i, :or for facets value, key :tab for category, :text for search term)
  # @return ActionViewer handler with @records, @facets, @sets, @redux_state
  # for both views and react rendering
  def index
    params[:i] = sanitize_hash(params[:i]) if params[:i]
    params[:or] = sanitize_hash(params[:or]) if params[:or]

    SearchTab.add_category_facets(@search, params[:tab])
    @records = @search.results
    @facets = @search.facets
    @sets = current_sj_user.try(:sets)

    raw_category_counts = tab_counts(params.dup)
    full_counts = SearchTab.sorted_counts(raw_category_counts)
    full_counts.merge!(SearchTab.more_categories_sum(raw_category_counts))
    full_counts.merge!(raw_category_counts)

    @redux_state = Presenters::SearchPageStore.new.call(@search, full_counts)
  end

  def show
    @record = Record.find(params[:id], params[:search])

    # TODO: Check whether this condition should only apply if the only category is 'Sets'
    if @record.present? && @record.attributes[:category].include?('Sets')
      search_params = params[:search] ? params[:search].merge(record_id: params[:id]) : nil

      user_set_id = @record.landing_url.split('/').last
      redirect_to user_set_path(user_set_id, search: search_params)
    end
  end

  private

  def tab_counts(options = {})
    options.delete(:tab)

    counts_search = Search.new(options)
    Hash.new(0).merge(counts_search.categories) rescue {}
  end

  # Params Hash  saved as hidden fields when passed back into
  # the controller needs to be sanitized.
  def sanitize_hash(params_i)
    eval params_i.to_s.gsub("'", "\\\\'").gsub("\"", "'").gsub(":", "=>")
  end
end
