class CreateCommunities < ActiveRecord::Migration
  def change
    create_table :communities do |t|
      t.string :name
      t.string :slug
      t.string :kete_slug
      t.text :description
      t.string :feature_image_url

      t.timestamps
    end
    add_index :communities, :slug
  end
end

