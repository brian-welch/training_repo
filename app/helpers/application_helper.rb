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

end
