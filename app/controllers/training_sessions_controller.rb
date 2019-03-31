class TrainingSessionsController < ApplicationController

  def index
    @title = "#{current_user.first_name.capitalize}'s Session Histroy on Training Repo"
    @all_my_sessions = TrainingSession.where(user: current_user)
  end

  def new
    if TrainingSession.active_session_number(current_user.id)
      flash[:alert] = "You already have any active training sessions.<br>You must end the session or save a set."
      redirect_to session_sets_path
    else
      @title = "#{current_user.first_name.capitalize}'s Starting a New Trianing Session on Training Repo"
      @new_training_session = TrainingSession.new
      all_session_strat_hash = SessionStrategy.all_session_strat_hash
      @first_session_strat = all_session_strat_hash.first
      @all_session_strat_json = all_session_strat_hash.to_json
    end
  end

  def show
    @title = "#{current_user.first_name.capitalize}'s Training Session Details on Training Repo"
  end

  def create

    if TrainingSession.active_session_number(current_user.id)
      flash[:alert] = "You already have any active training sessions.<br>You must end the session or save a set."
      redirect_to session_sets_path
    else
      new_training_session = TrainingSession.new(approved_training_session_params)
      new_sesh_number = TrainingSession.next_session_number(current_user.id)
      new_training_session.session_number = new_sesh_number

      if new_training_session.save
        flash[:notice] = "Your #{ordinal(new_sesh_number)} session has started!<br>Get to it!"
        redirect_to session_sets_path
      else
        flash[:alert] = "Something Went Pair Shaped"
        render "training_sessions/new"
      end
    end
  end

  def update

    sesh_to_update = TrainingSession.find(params["id"].to_i)
    sesh_to_update.open = false

    if sesh_to_update.save
      flash[:notice] = "You've just completed your #{ordinal(sesh_to_update.session_number)} session!"
      redirect_to training_sessions_path
    else
      flash[:alert] = "Something Went Pair Shaped"
      redirect_to request.fullpath
    end
  end

  private

  def approved_training_session_params
    params.require(:training_session).permit(:user_id, :session_strategy_id)
  end

end
