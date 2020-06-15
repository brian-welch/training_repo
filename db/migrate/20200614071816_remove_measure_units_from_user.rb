class RemoveMeasureUnitsFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :weight_units, :string
    remove_column :users, :distance_units, :string
  end
end
