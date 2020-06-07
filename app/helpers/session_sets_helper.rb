module SessionSetsHelper
  include CalculationsHelper

  def render_session_sets(args, &block)
    # KEEP
    temp = ''
    if !args[:archived]
      temp = set_anchor_point(args[:sets].last.id) + exercise_toggle_tabs(args[:index] + 1)
    end
    (temp + set_block(args)).html_safe
  end

  def set_anchor_point(id)
    # KEEP
    content_tag :div, class: "exercise_set_marker", id: "set-#{id}" do
    end
  end

  def exercise_toggle_tabs(indexer)
    # KEEP
    content_tag :div, class: "exercise_toggle_container" do
      tab_builder(indexer).join("").html_safe
    end
  end

  def tab_builder(indexer)
    # KEEP
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
    # KEEP
    classes = !args[:archived] ? "exercise_set_container" : "exercise_set_container prior_saved_exercise"
    content_tag :div, class: classes, data: {"content-set-group" => (args[:index] + 1)} do
      (args[:archived] ? prior_exercise_name(args) : exercise_name(args)).html_safe +
      sets_data(args) +
      total_weight_block(args[:sets]) +
      set_of_this_button(args[:exercise_inst], args[:sets].last)
    end
  end

  def prior_exercise_name(args)
    # KEEP
    content_tag :div, class: "session_set_index_exercise_name" do
      content_tag(:span, image_tag("logo_and_branding/tr_check_a.svg"), class: "icon_image_exercise_name") +
      "#{proper_string(args[:exercise_inst].name) +
      '<br><i class="fas fa-angle-double-right fa-fw" style="margin-right: 8px;" ></i>' +
      proper_string(args[:resist_inst].name) + "#{(args[:resist_inst].bodyweight && args[:sets].count > 0) ? (' @ ' + current_user.get_relevant_user_weight(args[:sets][0]).to_s + ' ' + @units) : ''}" +
      '<br>' + sets_date(args[:sets])}".html_safe
    end
  end

  def exercise_name(args)
    # KEEP
    content_tag :div, class: "session_set_index_exercise_name" do
      content_tag(:span, image_tag("logo_and_branding/tr_check_a.svg"), class: "icon_image_exercise_name") +
      "#{proper_string(args[:exercise_inst].name) + '<br><i class="fas fa-angle-double-right fa-fw" style="margin-right: 8px;" ></i>' + proper_string(args[:resist_inst].name)}".html_safe
    end
  end

  def sets_date(sets)
    # KEEP
    mssg_b = " First time doing this exercise! <i class=\"fas fa-grin-alt\"></i>"
    mssg = sets.count.zero? ? mssg_b : "Last trained on: #{sets.last.created_at.to_date}"
    content_tag :span, class: "prior_set_message" do
      # image_tag("logo_and_branding/tr_spiral_c.svg",
      #   style: "height: 18px; position: relative; bottom: 1px;") +
      "#{mssg}".html_safe
    end
  end

  def sets_data(args)
    # KEEP
    sets_without_machine(args[:additional], args[:sets], args[:last_set_saved_id])
  end

  def sets_without_machine(additional, sets, last_id)
    # KEEP
    (additional ? additional_name(additional) : "").html_safe +
    sets.map do |set|
      reps_weight(set, last_id)
    end.join("").html_safe
  end

  def reps_weight(set, last_id)
    # KEEP
    classes = set.id == last_id ? "saved_set_data_box last_saved_set_border" : "saved_set_data_box"
    marker = set.id == last_id ? "<div class=\"last_saved_set_marker\"></div>" : ""
    weight = content_tag :div, class: "set_data_weight" do
      "#{set.weight} <span>#{@units}</span>".html_safe
    end
    reps = content_tag :div, class: "set_data_reps" do
      "#{set.reps} <span>reps</span>".html_safe
    end
    content_tag :div, class: classes,
      data: {"set-id" => set.id} do
      (marker + weight + reps).html_safe
    end
  end

  def additional_name(additional)
    # KEEP
    content_tag :div, class: "session_set_index_machine_name", style: "margin: -10px 0 10px 52px;" do
      image_tag("logo_and_branding/tr_spiral_c.svg",
        style: "") +
      " #{proper_string(additional)}"
    end
  end

  def total_weight_block(sets)
    # KEEP
    label = content_tag :span, class: "set_data_total_weight_title" do
      "Total:<br>".html_safe
    end
    sum = content_tag :span, class: "set_data_total_weight_sum" do
      # method: total_weight_lifted_in_sets_array located in CalculationsHelper
      "#{total_weight_lifted_in_sets_array(sets)} #{@units}"
    end
    content_tag :div, class: "save_set_data_total_weight" do
      label + sum + content_tag(:span, " ⓘ", class: "cursor_pointer", onclick: "calculationMessage()")
    end
  end


  def set_of_this_button(exercise_inst, set)
    # KEEP
    if set
      link_to new_session_set_path(
        exercise_id: set.exercise_id,
        machine_id: set.machine_id,
        pulley_count: set.pulley_count,
        resistance_method_id: set.resistance_method_id) do
          content_tag :button, class: "btn btn-xs btn-info sesion_set_add_new_set_btn" do
            "<i class=\"fas fa-plus-circle\"></i> Set of This".html_safe
          end
        end
    end
  end

  def get_sets_last_inactive_sesh_with_exercise(exercise, resistance)
    # KEEP
    temp = SessionSet.where(:exercise => exercise, :resistance_method => resistance).sort_by { |set| set.created_at }.select{|set| set if set.training_session.open == false}
    temp = temp.select{|x| x.training_session_id == temp.last.training_session_id}
    return temp
  end

end
