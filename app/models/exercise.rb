class Exercise < ApplicationRecord
  has_many :exercise_bodyparts
  has_many :bodyparts, through: :exercise_bodyparts

  private

  private

  def self.all_exercise_hash
    all_exercise_inst = self.all
    all_exercise_hash = {}
    all_exercise_inst.each do |record|
      all_exercise_hash[record.id] = record.name
    end
    return all_exercise_hash
  end

end
