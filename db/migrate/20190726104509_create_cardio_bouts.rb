class CreateCardioBouts < ActiveRecord::Migration[5.2]
  def change
    create_table :cardio_bouts do |t|
      t.string :name

      t.timestamps
    end
  end
end
