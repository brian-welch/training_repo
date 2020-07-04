class AddColumnToSessionCardioBouts < ActiveRecord::Migration[5.2]
  def change
    add_column :session_cardio_bouts, :calories, :float
  end
end
