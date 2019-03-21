class CreateSessionExercises < ActiveRecord::Migration[5.2]
  def change
    create_table :session_exercises do |t|
      t.integer :weight_kg
      t.integer :reps
      t.references :training_session, foreign_key: true
      t.references :exercise, foreign_key: true
      t.references :machine, foreign_key: true

      t.timestamps
    end
  end
end
