class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :birthdate, :date
    add_column :users, :active, :boolean, default: false
    add_column :users, :weight, :integer

    add_reference :users, :role, foreign_key: true
    add_reference :users, :gender, foreign_key: true
  end
end
