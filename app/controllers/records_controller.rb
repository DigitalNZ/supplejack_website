# frozen_string_literal: true

class RecordsController < ApplicationController
  def home; end

  def index
    SearchTab.add_category_facets(@search, params[:tab])
    @records = @search.results
    @facets = @search.facets
    @counts = tab_counts(params.dup)
    @sets = current_sj_user&.sets
  end

  def show
    @record = Record.find(params[:id], params[:search] || {})

    return unless @record.present? && @record.attributes[:category].equal?(['Sets'])

    search_params = params[:search] ? params[:search].merge(record_id: params[:id]) : nil
    user_set_id = @record.landing_url.split('/').last
    redirect_to user_set_path(user_set_id, search: search_params)
  end

  private

    def tab_counts(options = {})
      options.delete(:tab)

      counts_search = Search.new(options)
      begin
        Hash.new(0).merge(counts_search.categories)
      rescue StandardError
        {}
      end
    end
end
