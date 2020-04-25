class Exercise < ApplicationRecord
  has_many :exercise_bodyparts, dependent: :destroy
  has_many :bodyparts, through: :exercise_bodyparts, dependent: :destroy

  # validates :name, presence: true, if: :name_has_correct_ending?

  private

  # def name_has_correct_ending?
  #   acceptible_endings = %w[dumbbell barbell crossover machine plate-loaded cable bodyweight]
  #   if self.name.include?("-")
  #     temp = self.name.split("-").map!{|x| x.strip}.last.downcase
  #     if acceptible_endings.include?(temp)
  #       return true
  #     else
  #       return false
  #     end
  #   else
  #     return false
  #   end
  # end


  def self.all_exercise_hash
    all_exercise_inst = self.all
    all_exercise_hash = {}
    all_exercise_inst.each do |record|
      all_exercise_hash[record.id] = record.name
    end
    return all_exercise_hash
  end

end
