class AddColumnToMachines < ActiveRecord::Migration[5.2]
  def change
    add_reference :machines, :model_series_id, foreign_key: true
  end
end
