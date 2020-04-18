class RemoveResistanceMethodFromExercise < ActiveRecord::Migration[5.2]
  def change
  	remove_reference :exercises, :resistance_method, foreign_key: true
  end
end
