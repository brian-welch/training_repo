class AddColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :weight_units, :string
    add_column :users, :distance_units, :string
  end
end
