
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

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :birthdate, presence: true
  validates :gender, presence: true
  validates :role, presence: true
  validates :weight, presence: true
  validates :email, uniqueness: true
  validates :units_of_measure, presence: true

  # after_create :send_welcome_email

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end

end
