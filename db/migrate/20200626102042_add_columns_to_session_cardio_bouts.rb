class AddColumnsToSessionCardioBouts < ActiveRecord::Migration[5.2]
  def change
    add_column :session_cardio_bouts, :max_hr, :integer
    add_column :session_cardio_bouts, :resistance_level, :string
    add_column :session_cardio_bouts, :incline_degrees, :float
    add_column :session_cardio_bouts, :average_speed, :float
    add_column :session_cardio_bouts, :estimated_calories, :integer
    add_column :session_cardio_bouts, :steps, :integer
    add_column :session_cardio_bouts, :floors, :integer
    add_column :session_cardio_bouts, :vertical_distance, :float
    add_column :session_cardio_bouts, :mets, :integer
    add_column :session_cardio_bouts, :laps, :float
  end
end
