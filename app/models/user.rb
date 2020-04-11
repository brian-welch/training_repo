
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  #devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :validatable

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable#,
         # :trackable,
         # :confirmable,
         # :lockable

  has_many :session_sets
  belongs_to :gender
  belongs_to :role

  attr_accessor :weight

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :birthdate, presence: true
  validates :gender, presence: true
  validates :role, presence: true
  validates :email, uniqueness: true
  validates :units_of_measure, presence: true
  validates :units_of_measure, inclusion: { in: %w(lbs kg),
    message: "%{value} is not a valid unit" }
  # after_create :send_welcome_email



  private

  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end

end
