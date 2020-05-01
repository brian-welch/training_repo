module ApplicationHelper
  include ActiveSupport::Concern

  def title
    content_tag(:title, @title || "Training Repo: Scientific Workout Analytics")
  end


  def mechanical_deductions(set)
    mech_ad_value_1 = current_user.gender.name.downcase == "m" ? set.exercise.m_mech_ad_override : set.exercise.f_mech_ad_override
    mech_ad_value_2 = set.machine ? (set.machine.mech_ad * set.machine.pulley_count) : 1
    return (mech_ad_value_1 ? mech_ad_value_1 : 1) * mech_ad_value_2 * set.pulley_count
    # if !set.machine.nil?
    #   (set.machine.mech_ad * set.machine.pulley_count * set.pulley_count)
    # else
    #   return set.pulley_count
    # end
  end

  def set_mech_ad(set)
    mech_ad_value_1 = current_user.gender.name.downcase == "m" ? set.exercise.m_mech_ad_override : set.exercise.f_mech_ad_override
    mech_ad_value_2 = set.machine ? (set.machine.mech_ad * set.machine.pulley_count) : 1
    # mech_ad_value_3 = set.machine ? set.machine.pulley_count if set : 1
    return (mech_ad_value_1 ? mech_ad_value_1 : 1) * mech_ad_value_2 * set.pulley_count
    # mech_ad_value ? mech_ad_value : 1
  end


  def proper_string(string)
    return string.split(" ").map{|x| x.capitalize}.join(" ")
  end

  def user_is_active?
    return current_user.active
  end

  def last_session_this_strategy
    TrainingSession.where("user_id = ? AND session_strategy_id = ? AND open = ?",
      current_user.id,
      TrainingSession.active_session_instance(current_user).session_strategy_id,
      false).last
  end

  def get_sets_last_inactive_sesh_with_exercise(exercise)
    temp =  SessionSet.where("exercise_id = ?", exercise.id).select{|x| x if x.training_session.open == false}
    temp = temp.select{|x| x.training_session_id == temp.last.training_session_id}
    return temp
  end

  def active_session?
    if user_signed_in?
      @is_active_session = TrainingSession.active_session_call(current_user).count == 0 ? false : true
    else
      @is_active_session = false
    end
  end

  def is_unilateral?(exercise_inst, resist_inst)
    (resist_inst.unilateral || exercise_inst.unilateral) && !exercise_inst.force_bilateral
  end

end
