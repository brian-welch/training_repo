class CreateUserWeights < ActiveRecord::Migration[5.2]
  def change
    create_table :user_weights do |t|
      t.references :user, foreign_key: true
      t.integer :weight

      t.timestamps
    end
  end
end
