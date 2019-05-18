class CreateMachines < ActiveRecord::Migration[5.2]
  def change
    create_table :machines do |t|
      t.references :brand
      t.string :name
      t.float :mech_ad
      t.integer :pulley_count
      t.integer :inherit_weight, default: 0

      t.timestamps
    end
  end
end
