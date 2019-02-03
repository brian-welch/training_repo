class Exercise < ApplicationRecord
  has_many :exercise_bodyparts
  has_many :bodyparts, through: :exercise_bodyparts
end
