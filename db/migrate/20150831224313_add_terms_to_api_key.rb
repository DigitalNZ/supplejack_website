# frozen_string_literal: true

class AddTermsToApiKey < ActiveRecord::Migration[4.2]
  def change
    add_column :api_keys, :terms, :boolean, default: true
  end
end
