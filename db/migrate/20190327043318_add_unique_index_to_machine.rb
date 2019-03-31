class AddUniqueIndexToMachine < ActiveRecord::Migration[5.2]
  def change
    add_index :machines, [:name, :brand_id], unique: true
  end
end
