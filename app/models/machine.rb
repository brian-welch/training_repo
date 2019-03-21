class Machine < ApplicationRecord
  has_many :session_exercises
  belongs_to :brand
end
