class AddColumnsToSessionCardioBoutsTable < ActiveRecord::Migration[5.2]
  def change
    add_column :session_cardio_bouts_tables, :max_hr, :integer
    add_column :session_cardio_bouts_tables, :resistance_level, :string
    add_column :session_cardio_bouts_tables, :incline_degrees, :float
    add_column :session_cardio_bouts_tables, :average_speed, :float
    add_column :session_cardio_bouts_tables, :estimated_calories, :integer
    add_column :session_cardio_bouts_tables, :steps, :integer
    add_column :session_cardio_bouts_tables, :floors, :integer
    add_column :session_cardio_bouts_tables, :vertical_distance, :float
    add_column :session_cardio_bouts_tables, :mets, :integer
    add_column :session_cardio_bouts_tables, :laps, :float
  end
end
