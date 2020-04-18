class AddColumnsToExercise < ActiveRecord::Migration[5.2]
  def change
    add_column :exercises, :force_bilateral, :boolean
    add_column :exercises, :info, :text
    add_column :exercises, :m_mech_ad_override, :float
    add_column :exercises, :f_mech_ad_override, :float
  end
end
