class SessionSet < ApplicationRecord
  belongs_to :training_session
  belongs_to :machine, optional: true#, foreign_key: :machine
  belongs_to :exercise

  validates :weight, presence: true
  validates :reps, presence: true
  validates :pulley_count, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :machine, presence: true, if: :machine_id_required?

  def machine_id_required?
    if exercise
      temp = exercise.name.split(" ").last.downcase
      if temp == "machine" || temp == "plate-loaded"
        return true
      else
        return false
      end
    else
      return false
    end
  end

  def exercise_name
    exercise.try(:name)
  end

  def exercise_name=(name)
    self.exercise = Exercise.find_by(name: name) if name.present? # find_or_create_by
  end

end
