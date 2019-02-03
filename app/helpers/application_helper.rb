module ApplicationHelper

  def title
    content_tag(:title, @title || "Training Repo: Workout Analytics")
  end

end
