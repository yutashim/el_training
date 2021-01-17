class AddIndexToUsersColumns < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :id
    add_index :users, :email, unique: true
  end
end
