class CreateTrainingSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :training_sessions do |t|
      t.integer :session_number
      t.boolean :open, default: true
      t.references :session_strategy, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
