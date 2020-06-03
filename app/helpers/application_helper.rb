module ApplicationHelper
  include ActiveSupport::Concern

  def title
    content_tag(:title, @title || "Training Repo: Scientific Workout Analytics")
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

  def set_is_active_session_instance_variable
    # sets boolean value for the instance variable '@is_active_session' and session key value pair
    if user_signed_in?
      @active_session_call = TrainingSession.active_session_call(current_user)
      session[:is_active_session] = @active_session_call.count == 0 ? false : true
      @is_active_session = session[:is_active_session].dup
    else
      @is_active_session = false
    end
  end

  def set_current_session_instance_variable
    # sets a TrainingSession Instance in an instance variable '@current_session'
    @current_session = @active_session_call[0]
  end

  def is_unilateral?(exercise_inst, resist_inst)
    (resist_inst.unilateral || exercise_inst.unilateral) && !exercise_inst.force_bilateral
  end

end
