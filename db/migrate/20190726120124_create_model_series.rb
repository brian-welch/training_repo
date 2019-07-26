class CreateModelSeries < ActiveRecord::Migration[5.2]
  def change
    create_table :model_series do |t|
      t.string :name
    end
  end
end
