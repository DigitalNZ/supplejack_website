# frozen_string_literal: true

class AddUsernameToUser < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :username, :string
  end
end
