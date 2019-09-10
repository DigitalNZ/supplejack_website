# frozen_string_literal: true

class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records, &:timestamps
  end
end
