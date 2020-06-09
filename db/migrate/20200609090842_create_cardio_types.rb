class CreateCardioTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :cardio_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
