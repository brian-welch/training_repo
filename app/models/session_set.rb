class SessionSet < ApplicationRecord
  belongs_to :training_session
  belongs_to :machine, optional: true#, foreign_key: :machine
  belongs_to :exercise

  validates :weight_kg, presence: true
  validates :reps, presence: true
  validates :pulley_count, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :machine, presence: true, if: :machine_id_required?

  def machine_id_required?
    temp = exercise.name.split(" ")[0].downcase
    if temp == "machine" || temp == "plate-loaded"
      return true
    else
      return false
    end
  end

end
