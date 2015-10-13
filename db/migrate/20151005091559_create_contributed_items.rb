class CreateContributedItems < ActiveRecord::Migration
  def change
    create_table :contributed_items do |t|
      t.string :category
      t.string :name
      t.string :status
      t.text :description
      t.date :date_of_item
      t.string :creator
      t.string :copyright
      t.string :item_path
      t.integer :user_id

      t.timestamps
    end
    create_join_table :communities, :contributed_items
    add_index :contributed_items, :category
    add_index :contributed_items, :user_id
    add_index :contributed_items, :item_path
  end
end
