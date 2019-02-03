class CreateBodyparts < ActiveRecord::Migration[5.2]
  def change
    create_table :bodyparts do |t|
      t.string :name
      t.timestamps
    end
  end
end
