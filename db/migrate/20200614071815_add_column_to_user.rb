class AddColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :units_of_measure, :string
  end
end
