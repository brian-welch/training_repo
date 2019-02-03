class CreateExerciseBodyparts < ActiveRecord::Migration[5.2]
  def change
    create_table :exercise_bodyparts do |t|
      t.references :exercise, foreign_key: true
      t.references :bodypart, foreign_key: true
      t.timestamps
    end
  end
end
