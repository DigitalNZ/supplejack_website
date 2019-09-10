# frozen_string_literal: true

class AddTermsToApiKey < ActiveRecord::Migration
  def change
    add_column :api_keys, :terms, :boolean, default: true
  end
end
