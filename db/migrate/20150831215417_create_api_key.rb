class CreateApiKey < ActiveRecord::Migration
  def change
    create_table :api_keys do |t|
      t.integer :user_id
      t.string :token

      t.timestamps
    end
  end
end
