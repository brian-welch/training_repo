class SessionSetsController < ApplicationController
  before_action :make_exercise_json, only: [:new, :create]
  # before_action :make_default_machine, only: [:new, :create]
  before_action :call_active_training_session_instance, only: [:index, :new, :create]


  def index
    if @active_tr_sesh_inst
      @title = "Saved Sets on #{current_user.first_name.capitalize}'s #{ordinal(@active_tr_sesh_inst.session_number)} Training Session on Training Repo"
      all_sets_current_instances = SessionSet.where(training_session: @active_tr_sesh_inst)
      @last_set_saved_id = all_sets_current_instances.last.id if all_sets_current_instances.count > 0
      @exercise_set_hash = {}
      all_sets_current_instances.each do |set|
        if @exercise_set_hash[set.exercise].nil?
          @exercise_set_hash[set.exercise] = []
          @exercise_set_hash[set.exercise] << set
        else
          @exercise_set_hash[set.exercise] << set
        end
      end

    else
      flash[:alert] = "You do not have any active training sessions.<br>You can review previous sessions here."
      redirect_to training_sessions_path
    end
  end

  def show
  end

  def new
    if @active_tr_sesh_inst
      @new_session_set = SessionSet.new(training_session: @active_tr_sesh_inst, exercise_id: params[:exercise_id])
      # byebug
      if params[:exercise_id]
        @new_session_set.exercise_id = params[:exercise_id]
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

  def update
  end

  private

  def call_active_training_session_instance
    @active_tr_sesh_inst = TrainingSession.active_session_instance(current_user.id)
  end

  def make_exercise_json
    all_exercise_hash = Exercise.all_exercise_hash
    @all_exercise_json = all_exercise_hash.to_json
  end

  def make_default_machine
    @machine_default_select = Machine.find_by_name("No Machine")
  end

  def approved_session_set_params
    params.require(:session_set).permit(:weight_kg, :reps, :exercise_id, :machine_id, :pulley_count, :training_session_id)
  end

end
