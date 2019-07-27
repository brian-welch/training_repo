class CreateSessionCardioBouts < ActiveRecord::Migration[5.2]
  def change
    create_table :session_cardio_bouts do |t|
      t.float :distance
      t.datetime :duration

      t.references :training_session, foreign_key: true
      t.references :cardio_bout, foreign_key: true

      t.timestamps
    end
  end
end
