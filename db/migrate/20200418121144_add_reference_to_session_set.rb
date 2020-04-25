class AddReferenceToSessionSet < ActiveRecord::Migration[5.2]
  def change
    add_reference :session_sets, :resistance_method, foreign_key: true
  end
end
