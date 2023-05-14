class ChangeTableName < ActiveRecord::Migration[6.0]
  def change
    rename_table :labelings, :task_labels
  end
end
