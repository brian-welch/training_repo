module ApplicationHelper

  def title
    content_tag(:title, @title || "Training Repo: Scientific Workout Analytics")
  end


  def mechanical_deductions(set)
    if !set.machine.nil?
      (set.machine.mech_ad * set.machine.pulley_count * set.pulley_count)
    else
      return set.pulley_count
    end
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

end
