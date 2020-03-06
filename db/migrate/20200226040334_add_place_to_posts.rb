class AddPlaceToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :longitude, :float
    add_column :posts, :latitude, :float
    add_column :posts, :price, :decimal
  end
end
