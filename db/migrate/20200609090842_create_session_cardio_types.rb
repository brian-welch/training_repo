class CreateSessionCardioTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :session_cardio_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
