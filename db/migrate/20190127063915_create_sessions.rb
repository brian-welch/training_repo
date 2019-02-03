class CreateSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :sessions do |t|
      t.integer :session_number
      t.boolean :open
      t.references :session_strategy, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
