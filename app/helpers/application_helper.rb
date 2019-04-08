module ApplicationHelper

  def title
    content_tag(:title, @title || "Training Repo: Scientific Workout Analytics")
  end

  def open_session_status
    query = TrainingSession.active_session_call(current_user)
    {
      has_open_sesh?: query.count == 0 ? false : true,
      get_open_sesh_instance: query[0]
    }
  end

  def active_session?
    if user_signed_in?
      TrainingSession.active_session_call(current_user).count == 0 ? false : true
    else
      false
    end
  end

  def add_button_case(path)
    case path
    # when "/session_sets"
    #   "<li><a href=\"#{new_session_set_path}\"><i class=\"fas fa-plus-circle\"></i> Add a Set!</a></li>".html_safe
    when "/machines"
      "<li><a href=\"#{new_machine_path}\"><i class=\"fas fa-plus-circle\"></i> Add a Machine!</a></li>".html_safe
    else
      nil
    end
  end

  def total_weight_calculator_active_session(exercise_inst, sets_arr)
    bodyweight = exercise_inst.bodyweight == true ? current_user.weight : 0
    unilat = exercise_inst.unilateral == true ?  2 : 1
    sets_arr.sum do |set|
      ((set.weight_kg * unilat) + bodyweight) * set.reps
    end
  end

  def total_weight_calculator_show_session(exercise_inst, sets_order_arr)
    bodyweight = exercise_inst.bodyweight == true ? current_user.weight : 0
    unilat = exercise_inst.unilateral == true ?  2 : 1
    sets_order_arr.sum do |set_order_hash|
      ((set_order_hash[:set].weight_kg * unilat) + bodyweight) * set_order_hash[:set].reps
    end
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


end
