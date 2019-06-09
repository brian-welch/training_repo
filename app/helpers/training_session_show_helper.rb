module TrainingSessionShowHelper

  def total_weight_calculator_show_session(exercise_inst, machine_sets_order_arr)
    bodyweight = exercise_inst.bodyweight == true ? current_user.weight : 0
    unilat = exercise_inst.unilateral == true ?  2 : 1
    total = 0

    machine_sets_order_arr.each do |machine_inst, order_sets_array|
      total += order_sets_array.sum do |set|
        if machine_inst.is_a? Integer
          (((set[1].weight_kg * unilat) + bodyweight) * set[1].reps) / set[1].pulley_count
        else
          (((( (set[1].weight_kg + set[1].machine.inherit_weight) * unilat) + bodyweight) * set[1].reps) / (set[1].machine.mech_ad * set[1].machine.pulley_count * set[1].pulley_count))
        end
      end
    end
    return total.round
  end

end
