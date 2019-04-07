class Machine < ApplicationRecord
  has_many :session_sets
  belongs_to :brand

  validates :mech_ad, presence: true
  validates :pulley_count, presence: true
  validates :name, presence: true
  validates :name, uniqueness: { scope: [:brand],
    message: "- This machine already exists!" }

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

end
