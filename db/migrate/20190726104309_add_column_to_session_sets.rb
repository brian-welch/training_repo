class AddColumnToSessionSets < ActiveRecord::Migration[5.2]
  def change
    add_column :session_sets, :notes, :text
  end
end
