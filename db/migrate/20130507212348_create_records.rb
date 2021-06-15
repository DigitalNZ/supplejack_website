# frozen_string_literal: true

class CreateRecords < ActiveRecord::Migration[4.2]
  def change
    create_table :records, &:timestamps
  end
end
