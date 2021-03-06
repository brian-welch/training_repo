module CalculationsHelper
  include ActiveSupport::Concern

  def is_unilateral?(exercise_inst, resist_inst)
    # returns boolean whether or not an exercise was one armed or used dumbells or a crossover machine
    (resist_inst.unilateral || exercise_inst.unilateral) && !exercise_inst.force_bilateral
  end

  def mechanical_deductions(set)
    # returns any applicable mechanical advantage value of an single set
    mech_ad_value_1 = current_user.gender.name.downcase == "m" ? set.exercise.m_mech_ad_override : set.exercise.f_mech_ad_override
    mech_ad_value_2 = set.machine ? (set.machine.mech_ad * set.machine.pulley_count) : 1
    return (mech_ad_value_1 ? mech_ad_value_1 : 1) * mech_ad_value_2 * set.pulley_count

  end

  def total_weight_lifted_in_sets_array(set_arr)
    # returns an integer sum of the total weight lifted for a given array of sets
    # Called in Training Session Show & SessionSet Index
    set_arr.sum do |set|
      net_weight = set.machine ? set.weight + set.machine.inherit_weight : set.weight
      bodyweight = (set.resistance_method.bodyweight || set.exercise.bodyweight) ? current_user.get_relevant_user_weight(set) : 0
      unilat = is_unilateral?(set.exercise, set.resistance_method) ? 2 : 1
      ((((net_weight * unilat) + bodyweight) * set.reps) / mechanical_deductions(set)).to_i
    end
  end

  def total_weight_lifted_in_order_sets_array(order_set_arr)
    # returns a integer sum of the total weight lifted for a given array of order sets arrays
    # Called in Training Session Show
    order_set_arr.sum do |order,set|
      net_weight = set.machine ? set.weight + set.machine.inherit_weight : set.weight
      bodyweight = (set.resistance_method.bodyweight || set.exercise.bodyweight) ? current_user.get_relevant_user_weight(set) : 0
      unilat = is_unilateral?(set.exercise, set.resistance_method) ? 2 : 1
      ((((net_weight * unilat) + bodyweight) * set.reps) / mechanical_deductions(set)).to_i
    end
  end

  def session_total_minutes(sesh_inst)
    # returns integer of duration of training session in minutes
    (sesh_inst.updated_at - sesh_inst.created_at).round / 60
  end
  def get_session_duration(sesh_inst)
    # retuns a string with readable duration for the training_session:show summary header block
    minutes = session_total_minutes(sesh_inst)
    "#{(minutes / 60).to_i}hrs, #{minutes % 60}min"
  end

  def weight_lifted_per_hour_during_session(sesh_inst, total_weight)
    # returns an integer of rounded calculation of the pace of weight lifted
    (total_weight * 60) / session_total_minutes(sesh_inst)
  end

  def get_machine_or_pulley_or_neither(set)
    # returns a string if the set is on a machine or involves either a cable or crossover, otherwise returns nil
    # Called in session_sets_controller:index, training_sessions_controller:show
    resist_name = set.resistance_method.name.downcase
    if resist_name.include?("machine")
      set.machine
      # "#{proper_string(set.machine.name)} by #{proper_string(set.machine.brand.name)}"
    elsif resist_name.include?("cable") || resist_name.include?("crossover")
      "#{set.pulley_count} #{set.pulley_count > 1 ? 'Pulleys' : 'Pulley'}"
    else
      nil
    end
  end

end
