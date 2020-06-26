class SessionCardioBout < ApplicationRecord
  belongs_to :training_session
  belongs_to :cardio_type
  belongs_to :cardio_method

  validates :time, presence: true
  validates :distance, presence: true

end
