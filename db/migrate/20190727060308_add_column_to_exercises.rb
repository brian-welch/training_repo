class AddColumnToExercises < ActiveRecord::Migration[5.2]
  def change
    add_reference :exercises, :resistance_method, foreign_key: true
  end
end
