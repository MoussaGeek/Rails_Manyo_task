class AddAdmin < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :admin, :boolean, default: 0, null: false
    add_column :users, :tasks_count, :integer, default: 0, null: false
  end
end
