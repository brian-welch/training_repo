class RemoveColumnFromExercise < ActiveRecord::Migration[5.2]
  def change
    remove_column :exercises, :mech_ad, :integer
  end
end
