module TrainingSessionShowHelper

  def total_weight_calculator_show_session(exercise_inst, machine_sets_order_arr)
    has_bodyweight = exercise_inst.bodyweight # == true ? current_user.get_current_user_weight : 0
    unilat = exercise_inst.unilateral == true ?  2 : 1
    total = 0

    machine_sets_order_arr.each do |machine_inst, order_sets_array|
      total += order_sets_array.sum do |set|
        bodyweight = has_bodyweight  ? current_user.get_relevant_user_weight(set) : 0

        if machine_inst.is_a? Integer
          (((set[1].weight * unilat) + bodyweight) * set[1].reps) / set[1].pulley_count
        else
          (((( (set[1].weight + set[1].machine.inherit_weight) * unilat) + bodyweight) * set[1].reps) / (set[1].machine.mech_ad * set[1].machine.pulley_count * set[1].pulley_count))
        end
      end
    end

    return total.round
  end

end
