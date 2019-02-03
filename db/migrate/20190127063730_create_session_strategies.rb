class CreateSessionStrategies < ActiveRecord::Migration[5.2]
  def change
    create_table :session_strategies do |t|
      t.string :name
      t.text :description, array: true, default: []
      t.timestamps
    end
  end
end
