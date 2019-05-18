module ApplicationHelper

  def title
    content_tag(:title, @title || "Training Repo: Scientific Workout Analytics")
  end






  # def total_weight_calculator_show_session(exercise_inst, machine_sets_order_arr)
  #   bodyweight = exercise_inst.bodyweight == true ? current_user.weight : 0
  #   unilat = exercise_inst.unilateral == true ?  2 : 1
  #   total = 0

  #   machine_sets_order_arr.each do |machine_inst, order_sets_array|
  #     total += order_sets_array.sum do |set|
  #       if machine_inst.nil?
  #         (((set[1].weight_kg * unilat) + bodyweight) * set[1].reps) / set[1].pulley_count
  #       else
  #         (((set[1].weight_kg * unilat) + bodyweight) * set[1].reps) / (set[1].machine.mech_ad * set[1].machine.pulley_count * set[1].pulley_count)
  #       end
  #     end
  #   end
  #   return total.round
  # end





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
