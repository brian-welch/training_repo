class AddColumnToSessionCardioBouts < ActiveRecord::Migration[5.2]
  def change
    add_column :session_cardio_bouts, :sub_type, :string
  end
end
