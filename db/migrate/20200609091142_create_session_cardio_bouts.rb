class CreateSessionCardioBouts < ActiveRecord::Migration[5.2]
  def change
    create_table :session_cardio_bouts do |t|
      t.references :training_session, foreign_key: true
      t.references :cardio_type, foreign_key: true
      t.references :cardio_method, foreign_key: true
      t.integer :time
      t.float :distance
      t.string :notes

      t.timestamps
    end
  end
end
