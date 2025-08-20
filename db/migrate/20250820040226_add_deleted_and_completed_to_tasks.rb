class AddDeletedAndCompletedToTasks < ActiveRecord::Migration[8.0]
  def change
    add_column :tasks, :deleted, :boolean
    add_column :tasks, :completed, :boolean
  end
end
