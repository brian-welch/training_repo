class CreateCardioMethods < ActiveRecord::Migration[5.2]
  def change
    create_table :cardio_methods do |t|
      t.string :name

      t.timestamps
    end
  end
end
