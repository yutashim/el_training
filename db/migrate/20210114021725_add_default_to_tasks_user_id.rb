class AddDefaultToTasksUserId < ActiveRecord::Migration[5.2]
  def change
    change_column_default :tasks, :user_id, from: nil, to: 1
  end
end
