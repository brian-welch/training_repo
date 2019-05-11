class SessionSetsController < ApplicationController
  before_action :make_exercise_json, only: [:new, :create]
  before_action :call_active_training_session_instance, only: [:index, :new, :create]


  def index
    if @active_tr_sesh_inst
      @title = "Saved Sets on #{current_user.first_name.capitalize}'s #{ordinal(@active_tr_sesh_inst.session_number)} Training Session on Training Repo"

      @all_sets_current_instances = SessionSet.where(training_session: @active_tr_sesh_inst).reverse

      @all_sets_hash_by_exercise = @all_sets_current_instances.group_by { |set| set.exercise }

      @last_set_saved_id = @all_sets_current_instances.last.id if @all_sets_current_instances.count > 0

    else
      flash[:alert] = "You do not have any active training sessions.<br>You can review previous sessions here."
      redirect_to training_sessions_path
    end
  end


  def new
    if @active_tr_sesh_inst
      @new_session_set = SessionSet.new(training_session: @active_tr_sesh_inst, exercise_id: params[:exercise_id])
      if params[:exercise_id]
        @new_session_set.exercise_id = params[:exercise_id]
        if params[:machine]
          @new_session_set.machine_id = params[:machine]
        end
        if params[:pulley_count].to_i > 1
          @new_session_set.pulley_count = params[:pulley_count].to_i
        end
      end
      @title = "Adding a New Set to #{current_user.first_name.capitalize}'s #{ordinal(@active_tr_sesh_inst.session_number)} Session on Training Repo"
    else
      flash[:alert] = "You do not have any active training sessions.<br>You must first start a new training session before adding sets."
      redirect_to my_tr_path
    end
  end


  def create
    @new_session_set = SessionSet.new(approved_session_set_params)

    if @new_session_set.save
      redirect_to session_sets_path(anchor: "set-#{@new_session_set.id}")
    else
      flash[:alert] = "Something Went Pair Shaped"
      render :new
    end
  end


  private


  def call_active_training_session_instance
    @active_tr_sesh_inst = TrainingSession.active_session_instance(current_user.id)
  end


  def make_exercise_json
    all_exercise_hash = Exercise.all_exercise_hash
    @all_exercise_json = all_exercise_hash.to_json
  end


  def approved_session_set_params
    params.require(:session_set).permit(:weight_kg, :reps, :exercise_id, :machine_id, :pulley_count, :training_session_id)
  end

end
