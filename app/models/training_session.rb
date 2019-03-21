class TrainingSession < ApplicationRecord
  belongs_to :session_strategy
  belongs_to :user

  validates :session_strategy_id, presence: true

  def self.active_session_number(user)
    active_sesh = active_session_call(user)
    if active_sesh.count == 0
      return false
    else
      return active_sesh.last.session_number
    end
  end


  def self.next_session_number(user)
    previous_sesh = previous_session_call(user)

    if previous_sesh.count == 0
      return 1
    else
      return previous_sesh.last.session_number + 1
    end
  end

  def self.active_session_instance(user)
    active_sesh = active_session_call(user)
    if active_sesh.count == 0
      return nil
    else
      return active_sesh[0]
    end
  end

  private

  def self.active_session_call(user)
    # returns an array
    self.where("user_id = ? AND open = ?", user, true)
  end

  def self.previous_session_call(user)
    # returns an array
    self.where("user_id = ? AND open = ?", user, false)
  end

end
