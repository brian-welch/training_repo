class CreateMachines < ActiveRecord::Migration[5.2]
  def change
    create_table :machines do |t|
      t.references :brand
      t.string :name
      t.float :mech_ad

      t.timestamps
    end
  end
end
