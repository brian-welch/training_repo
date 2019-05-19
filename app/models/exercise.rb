class Exercise < ApplicationRecord
  has_many :exercise_bodyparts
  has_many :bodyparts, through: :exercise_bodyparts

  private


  def exercise_name
    exercise.try(:name)
  end

  def exercise_name=(name)
    self.exercise = Exercise.find_by_name(name) if name.present?
  end


  def self.all_exercise_hash
    all_exercise_inst = self.all
    all_exercise_hash = {}
    all_exercise_inst.each do |record|
      all_exercise_hash[record.id] = record.name
    end
    return all_exercise_hash
  end

end
