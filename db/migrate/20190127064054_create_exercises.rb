class CreateExercises < ActiveRecord::Migration[5.2]
  def change
    create_table :exercises do |t|
      t.string :name
      t.integer :pully_count
      t.boolean :unilateral
      t.integer :movement_class
      t.text :note
      t.timestamps
    end
  end
end
