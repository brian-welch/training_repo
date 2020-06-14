class RemoveUnitsOfMeassureFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :units_of_measure, :string
  end
end
