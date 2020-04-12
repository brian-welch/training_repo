
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

  attr_accessor :weight #to be used in saving weight to user_weights table
  has_many :user_weights, dependent: :destroy

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



  def get_current_user_weight
   UserWeight.where("user_id = ?", self.id).last.weight
  end

  def get_relevant_user_weight(set_input)
    set = set_input.is_a?(Array) ? set_input[1] : set_input
    relevant_weight = 0
    all_weights = UserWeight.where("user_id = ?", self.id)

    all_weights.map do |weight_record|
      break if weight_record.updated_at.to_i > set.updated_at.to_i
      relevant_weight = weight_record.weight
    end

    relevant_weight

  end

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end

end
