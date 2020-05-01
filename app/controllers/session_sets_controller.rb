class SessionSetsController < ApplicationController
  include CalculationsHelper
  before_action :make_exercise_json, only: [:new, :create]
  before_action :call_active_training_session_instance, only: [:index, :new, :create]


  def index
    if @active_tr_sesh_inst

      @title = "Saved Sets on #{current_user.first_name.capitalize}'s #{ordinal(@active_tr_sesh_inst.session_number)} Training Session on Training Repo"

      sets_current_training_session = SessionSet.where(training_session: @active_tr_sesh_inst).reverse

      @all_sets_hash_by_exercise_and_resistance = sets_current_training_session.group_by { |set| [set.exercise, set.resistance_method] }

      @sesh_sets_hash_by_exercise_resist_additional = sets_current_training_session.group_by { |set| [set.exercise, set.resistance_method, get_machine_or_pulley_or_neither(set)] }


      @last_set_saved_id = sets_current_training_session.first.id if sets_current_training_session.count > 0

    else
      flash[:alert] = "You do not have any active training sessions.<br>You can review previous sessions here."
      redirect_to training_sessions_path
    end
  end


  def new
    if !user_is_active?
      redirect_to inactive_path
    elsif @active_tr_sesh_inst
      @new_session_set = SessionSet.new(training_session: @active_tr_sesh_inst, exercise_id: params[:exercise_id])
      if params[:exercise_id]
        @new_session_set.exercise_id = params[:exercise_id]
        if params[:machine_id]
          @new_session_set.machine_id = params[:machine_id]
        end
        if params[:resistance_method_id]
          @new_session_set.resistance_method_id = params[:resistance_method_id].to_i
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
      flash[:alert] = "Something went sideways...<br>Was that an exercise from<br>the database list?"
      render :new
    end
  end


  private


  def get_machine_or_pulley_or_neither(set)
    resist_name = set.resistance_method.name.downcase
    if resist_name.include?("machine")
      return "#{proper_string(set.machine.name)} by #{proper_string(set.machine.brand.name)}"
    elsif resist_name.include?("cable"||"crossover")
      return "#{set.pulley_count} #{set.pulley_count > 1 ? 'Pulleys' : 'Pulley'}"
    else
      return nil
    end
  end


  def call_active_training_session_instance
    @active_tr_sesh_inst = TrainingSession.active_session_instance(current_user.id)
  end


  def make_exercise_json
    all_exercise_hash = Exercise.all_exercise_hash
    @all_exercise_json = all_exercise_hash.to_json
  end


  def approved_session_set_params
    params.require(:session_set).permit(:weight, :reps, :exercise_id, :exercise_name, :machine_id, :pulley_count, :training_session_id, :resistance_method_id)
  end

end
