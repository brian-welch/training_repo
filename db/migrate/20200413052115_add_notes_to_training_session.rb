class AddNotesToTrainingSession < ActiveRecord::Migration[5.2]
  def change
    add_column :training_sessions, :notes, :text
  end
end
