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


  def total_weight_calculator_active_session(exercise_inst, machine_set_hash)
    bodyweight = exercise_inst.bodyweight == true ? current_user.weight : 0
    unilat = exercise_inst.unilateral == true ?  2 : 1
    temp = 0

    machine_set_hash.each do |k, array|
      temp += array.sum do |set|
        if set.machine.nil?
          (((set.weight_kg * unilat) + bodyweight) * set.reps) / set.pulley_count
        else
          (((set.weight_kg * unilat) + bodyweight) * set.reps) / (set.machine.mech_ad * set.machine.pulley_count * set.pulley_count)
        end
      end
    end
    return temp.round
  end

  def total_weight_calculator_show_session(exercise_inst, machine_sets_order_arr)
    bodyweight = exercise_inst.bodyweight == true ? current_user.weight : 0
    unilat = exercise_inst.unilateral == true ?  2 : 1
    temp = 0

    machine_sets_order_arr.each do |k, sets_order_hash|
      temp += sets_order_hash.sum do |set|
        if set[:set].machine.nil?
          (((set[:set].weight_kg * unilat) + bodyweight) * set[:set].reps) / set[:set].pulley_count
        else
          (((set[:set].weight_kg * unilat) + bodyweight) * set[:set].reps) / (set[:set].machine.mech_ad * set[:set].machine.pulley_count * set[:set].pulley_count)
        end
      end
    end
    return temp.round
  end

  def total_weight_calculator_prior_session(sets_array)
    bodyweight = sets_array[0].exercise.bodyweight == true ? current_user.weight : 0
    unilat = sets_array[0].exercise.unilateral == true ?  2 : 1
    temp = 0

    temp += sets_array.sum do |set|
      if set.machine.nil?
        (((set.weight_kg * unilat) + bodyweight) * set.reps) / set.pulley_count
      else
        (((set.weight_kg * unilat) + bodyweight) * set.reps) / (set.machine.mech_ad * set.machine.pulley_count * set.pulley_count)
      end
    end
    return temp.round
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

end
