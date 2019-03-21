class SessionExercisesController < ApplicationController



  def index
    if TrainingSession.active_session_number(current_user.id)
      @title = "Saved Sets on #{current_user.first_name.capitalize}'s #{ordinal(TrainingSession.active_session_number(current_user))} Training Session on Training Repo"
      @active_session_instance = TrainingSession.active_session_instance(current_user)
    else
      flash[:alert] = "You do not have any active training sessions.<br>You can review previous sessions here."
      redirect_to training_sessions_path
    end
  end

  def show
  end

  def new
    if TrainingSession.active_session_number(current_user.id)

      active_sesh = TrainingSession.active_session_instance(current_user)
      @new_session_exercise = SessionExercise.new(training_session: active_sesh)

      @title = "#{current_user.first_name.capitalize}'s Adding a New Set to their #{ordinal(active_sesh.session_number)} Session on Training Repo"

      all_exercise_hash = Exercise.all_exercise_hash
      @all_exercise_json = all_exercise_hash.to_json

      @machine_default_select = Machine.find_by_name("-- Select --")

    else
      flash[:alert] = "You do not have any active training sessions.<br>You must first start a new training session before adding sets."
      redirect_to my_tr_path
    end
  end

  def create

  end
  def update
  end

  private

  def approved_training_session_params
    params.require(:training_session).permit(:user_id, :session_strategy_id)
  end

end
