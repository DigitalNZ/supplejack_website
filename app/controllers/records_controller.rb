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
  def home
    @search = search
  end

  def index
    @search = search(params.dup)
    SearchTab.add_category_facets(@search, params[:tab])
    @records = @search.results
    @facets = @search.facets
    @counts = tab_counts(params.dup)
    @sets = current_sj_user.try(:sets)
  end

  def show
    @record = Record.find(params[:id], params[:search])

    if @record.present? && @record.attributes[:category].equal?(['Sets'])
      search_params = params[:search] ? params[:search].merge(record_id: params[:id]) : nil

      user_set_id = @record.landing_url.split('/').last
      redirect_to user_set_path(user_set_id, search: search_params)
    end

    @search = search(params[:search])
  end

  private

  def tab_counts(options = {})
    options.delete(:tab)

    counts_search = Search.new(options)
    Hash.new(0).merge(counts_search.categories) rescue {}
  end
end
