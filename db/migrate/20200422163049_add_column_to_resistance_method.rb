class AddColumnToResistanceMethod < ActiveRecord::Migration[5.2]
  def change
    add_column :resistance_methods, :bodyweight, :boolean
  end
end
