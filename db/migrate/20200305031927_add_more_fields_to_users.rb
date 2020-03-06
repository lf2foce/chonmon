class AddMoreFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :full_name, :string
    add_column :users, :website, :string
    add_column :users, :bio, :text
    add_column :users, :phone, :integer
    add_column :users, :gender, :string
  end
end
