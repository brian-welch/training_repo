class SessionStrategy < ApplicationRecord

  private

  def self.all_session_strat_hash
    all_sesh_strat_inst = self.all.sort_by{|x| x.name}
    all_sesh_strat_hash = {}
    all_sesh_strat_inst.each do |record|
      temp = []
      temp << record.name
      temp << record.description
      all_sesh_strat_hash[record.id] = temp
    end
    return all_sesh_strat_hash
  end

end
