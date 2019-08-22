class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.string :image_url
      t.references :category, null: false, foreign_key: true
      t.integer :rating

      t.timestamps
    end
  end
end
