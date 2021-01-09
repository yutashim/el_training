class AddDeadlineToTasks2 < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :deadline, :datetime, null: false,
    default: Time.zone.now + 1.year
  end
end
