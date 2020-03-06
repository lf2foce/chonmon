class AddPlaceAddressToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :address, :string
  end
end
