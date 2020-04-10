class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :session_sets, :weight_kg, :weight
  end
end
