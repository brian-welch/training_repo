class ResistanceMethod < ApplicationRecord

  def is_machine?
    self.name.downcase.include?("machine")
  end

end
