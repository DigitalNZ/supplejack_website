class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :user_set_id
      t.text :content

      t.timestamps
    end
    create_join_table :communities, :stories
    create_join_table :communities, :users
    add_index :stories, :user_set_id
  end
end
