class Machine < ApplicationRecord
  has_many :session_sets
  belongs_to :brand

  validates :pulley_count, presence: true
  validates :name, presence: true
  validates :name, uniqueness: { scope: [:brand],
    message: "- This machine already exists!" }

  validate :mech_ad_validator

  def self.all_machine_hash
    all_machine_inst = self.all
    all_machine_hash = {}
    all_machine_inst.each do |record|
      if all_machine_hash[record.brand_id].nil?
        all_machine_hash[record.brand_id] = []
        all_machine_hash[record.brand_id] << record.name.downcase
      else
        all_machine_hash[record.brand_id] << record.name.downcase
      end
    end
    return all_machine_hash
  end

  private

  def mech_ad_validator
    if !mech_ad.present? || mech_ad <= 0
      errors.add(:mech_ad, "#{:value} must be given and must be more than 0")
    end
  end

end
