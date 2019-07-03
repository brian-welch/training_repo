module SessionSetsHelper


  def render_session_sets(args, &block)
    set_anchor_point(args[:sets].last.id) +
    exercise_toggle_tabs(args[:index] + 1) +
    set_block(args)
  end

  def render_prior_session_sets(args, &block)
    set_block(args)
  end


  def set_anchor_point(id)
    content_tag :div, class: "exercise_set_marker", id: "set-#{id}" do
    end
  end

  def exercise_toggle_tabs(indexer)
    content_tag :div, class: "exercise_toggle_container" do
      tab_builder(indexer).join("").html_safe
    end
  end

  def tab_builder(indexer)
    labels = ["Current", "Previous"]
    active_class = ["active", ""]
    labels.map.with_index do |label, i|
      content_tag :div, class: "exercise_toggle #{active_class[i]}",
        data: {"button-set-group" => indexer} do
        label
      end
    end
  end

  def set_block(args)
    classes = !args[:archived] ? "exercise_set_container" : "exercise_set_container prior_saved_exercise"
    content_tag :div, class: classes,
        data: {"content-set-group" => (args[:index] + 1)} do
      exercise_name(args[:exercise_inst].name).html_safe +
      if args[:archived]
        sets_date(args[:sets])
      end +
      sets_data(args) +
      total_weight_block(args[:exercise_inst], args[:sets]) +
      set_of_this_button(args[:exercise_inst], args[:sets].last, args[:archived])
    end
  end

  def exercise_name(exercise_name)
    content_tag :div, class: "session_set_index_exercise_name" do
      image_tag("logo_and_branding/tr_check_a.svg",
        style: "height: 22px; position: relative; bottom: 1px;") +
      " #{proper_string(exercise_name)}"
    end
  end

  def sets_date(sets)
    mssg_b = " First time doing this exercise! <i class=\"fas fa-grin-alt\"></i>"
    mssg = sets.count.zero? ? mssg_b : " #{sets.last.created_at.to_date}"
    content_tag :div, class: "session_set_index_machine_name" do
      image_tag("logo_and_branding/tr_spiral_c.svg",
        style: "height: 18px; position: relative; bottom: 1px;") +
      " #{mssg}".html_safe
    end
  end

  def sets_data(args)
    if args[:exercise_inst].machine
      sets_with_machine(args[:sets], args[:last_set_saved_id])
    else
      sets_without_machine(args[:sets], args[:last_set_saved_id])
    end
  end

  def sets_with_machine(sets, last_id)
    machine_hash = sets.group_by {|set| set.machine }
    machine_hash.map do |machine, sets|
      machine_name(machine) +
      sets.map do |set|
        reps_kilos(set, last_id)
      end.join("").html_safe
    end.join("").html_safe
  end

  def sets_without_machine(sets, last_id)
    sets.map do |set|
      reps_kilos(set, last_id)
    end.join("").html_safe
  end

  def reps_kilos(set, last_id)
    classes = set.id == last_id ? "saved_set_data_box last_saved_set_border" : "saved_set_data_box"
    marker = set.id == last_id ? "<div class=\"last_saved_set_marker\"></div>" : ""
    weight = content_tag :div, class: "set_data_weight" do
      "#{set.weight_kg} <span>kg</span>".html_safe
    end
    reps = content_tag :div, class: "set_data_reps" do
      "#{set.reps} <span>reps</span>".html_safe
    end
    content_tag :div, class: classes,
      data: {"set-id" => set.id} do
      (marker + weight + reps).html_safe
    end
  end

  def machine_name(machine)
    content_tag :div, class: "session_set_index_machine_name" do
      image_tag("logo_and_branding/tr_spiral_c.svg",
        style: "height: 18px; position: relative; bottom: 1px;") +
      " #{proper_string(machine.name)} :: #{proper_string(machine.brand.name)}"
    end
  end

  def total_weight_block(exercise_inst, sets)
    label = content_tag :span, class: "set_data_total_weight_title" do
      "Total:<br>".html_safe
    end
    sum = content_tag :span, class: "set_data_total_weight_sum" do
      "#{total_weight(exercise_inst, sets)} kg *"
    end
    content_tag :div, class: "save_set_data_total_weight" do
      label + sum
    end
  end

  def total_weight(exercise_inst, sets)
    bodyweight = exercise_inst.bodyweight == true ? current_user.weight : 0
    unilat = exercise_inst.unilateral == true ?  2 : 1
    temp = 0
    temp += sets.sum do |set|
      if set.machine.nil?
        (((set.weight_kg * unilat) + bodyweight) * set.reps) / set.pulley_count
      else
        (((((set.weight_kg + set.machine.inherit_weight) * unilat) + bodyweight) * set.reps) / (set.machine.mech_ad * set.machine.pulley_count * set.pulley_count))
      end
    end
    return temp.round
  end

  def set_of_this_button(exercise_inst, set, archived)
    if !archived
      link_to new_session_set_path(
        exercise_id: exercise_inst.id,
        machine: set.machine,
        pulley_count: set.pulley_count) do
          content_tag :button, class: "btn btn-xs btn-info sesion_set_add_new_set_btn" do
            "<i class=\"fas fa-plus-circle\"></i> Set of This".html_safe
          end
      end
    end
  end

  def get_sets_last_inactive_sesh_with_exercise(exercise)

    temp =  SessionSet.where("exercise_id = ?", exercise.id).sort_by { |set| set.created_at }.select{|set| set if set.training_session.open == false}
    temp = temp.select{|x| x.training_session_id == temp.last.training_session_id}
    return temp
  end

  def pulley_check(exercise)
    %w(cable crossover).include?(exercise.name.split(" ")[-1].downcase)
  end

end
