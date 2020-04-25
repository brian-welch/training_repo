class CreateResistanceMethod < ActiveRecord::Migration[5.2]
  def change
    create_table :resistance_methods do |t|
      t.string :name
      t.string :instructions

      t.timestamps
    end
  end
end
