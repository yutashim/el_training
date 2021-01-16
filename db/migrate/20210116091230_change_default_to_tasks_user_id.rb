class ChangeDefaultToTasksUserId < ActiveRecord::Migration[5.2]
  def change
    change_column_default :tasks, :user_id, from: 1, to: nil
  end
end
