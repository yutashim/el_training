class ChangeColumnNullTasks < ActiveRecord::Migration[5.2]
  def change
    remove_column :tasks, :name, :string
    add_column :tasks, :title, :string, null: false
  end
  def up
    change_column :tasks, :detail, :text, null: false
  end
end
