class SessionExercise < ApplicationRecord
  belongs_to :training_session
  belongs_to :machine
  belongs_to :exercise

  validates :weight_kg, presence: true
  validates :reps, presence: true

end
