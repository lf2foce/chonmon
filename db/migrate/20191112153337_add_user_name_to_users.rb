class AddUserNameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :user_name, :string
    #them phan nay vao
    add_index :users, :user_name, unique: true
    add_column :users, :role, :string
  end
end
