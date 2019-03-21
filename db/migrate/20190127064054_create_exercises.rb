class CreateExercises < ActiveRecord::Migration[5.2]
  def change
    create_table :exercises do |t|
      t.string :name
      t.integer :mech_ad
      t.boolean :unilateral
      t.boolean :machine, default: false
      t.boolean :bodyweight, default: false

      t.timestamps
    end
  end
end
