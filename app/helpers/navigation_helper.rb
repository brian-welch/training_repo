module NavigationHelper

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



end
