class RemoveIndexFromUsersId < ActiveRecord::Migration[5.2]
  def change
    remove_index :users, column: [:id], name: 'index_users_on_id'
  end
end
