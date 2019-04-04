class AddColumnToMachine < ActiveRecord::Migration[5.2]
  def change
    add_column :machines, :pulley_count, :integer
  end
end
