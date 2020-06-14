class SessionCardioBoutsController < ApplicationController
  include CalculationsHelper
  # before_action :make_exercise_json, only: [:new, :create]
  before_action :call_active_training_session_instance, only: [:index, :new, :create]

  def index
  end

  def new
    if !user_is_active?
      redirect_to inactive_path
    elsif @active_tr_sesh_inst
      @new_session_cardio_bout = SessionCardioBout.new(training_session: @active_tr_sesh_inst, cardio_type_id: params[:cardio_type_id])
      if params[:cardio_type_id]
        @new_session_set.cardio_type_id = params[:cardio_type_id]
        if params[:distance]
          @new_session_set.distance = params[:distance]
        end
        if params[:cardio_method_id]
          @new_session_set.cardio_method_id = params[:cardio_method_id].to_i
        end
        if params[:time].to_i > 1
          @new_session_set.time = params[:time].to_i
        end
      end
      @title = "Adding a New Cardio Bout to #{current_user.first_name.capitalize}'s #{ordinal(@active_tr_sesh_inst.session_number)} Session on Training Repo"
    else
      flash[:info_1] = "You do not have any active training sessions.<br>You must first start a new training session before adding sets."
      redirect_to my_tr_path
    end
  end

  def create
    @params = params
  end

  def call_active_training_session_instance
    @active_tr_sesh_inst = TrainingSession.active_session_instance(current_user.id)
  end

  def approved_session_set_params
    params.require(:session_cardio_bout).permit(:distance, :time, :cardio_type_id, :cardio_type_name, :notes, :training_session_id, :cardio_method_id)
  end

end
