class AddColumnToSessionSet < ActiveRecord::Migration[5.2]
  def change
    add_column :session_sets, :pulley_count, :integer, default: 1
  end
end
