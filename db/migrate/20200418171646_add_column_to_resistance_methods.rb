class AddColumnToResistanceMethods < ActiveRecord::Migration[5.2]
  def change
    add_column :resistance_methods, :unilateral, :boolean
  end
end
