# frozen_string_literal: true

class CreateApiKey < ActiveRecord::Migration[4.2]
  def change
    create_table :api_keys do |t|
      t.integer :user_id
      t.string :token

      t.timestamps
    end
  end
end
