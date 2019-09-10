# frozen_string_literal: true

class AddUsernameToUser < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
  end
end
