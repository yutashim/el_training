class RemoveDeadlineToTasks < ActiveRecord::Migration[5.2]
  def up
    remove_column :tasks, :deadline, :datetime, null: false,
    default: Time.zone.now + 1.week
  end
  def down
    add_column :tasks, :deadline, :datetime, null: false,
    default: Time.zone.now + 1.week
  end
end
