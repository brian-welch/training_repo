class CreateResistanceMethods < ActiveRecord::Migration[5.2]
  def change
    create_table :resistance_methods do |t|

      t.timestamps
    end
  end
end