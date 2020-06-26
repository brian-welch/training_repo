class SessionCardioBoutsController < ApplicationController
  include CalculationsHelper
  before_action :call_active_training_session_instance, only: [:index, :new, :create]

  def index
    if @active_tr_sesh_inst

      @title = "#{current_user.first_name}'s Logged Cardio Bouts for Training Session ##{@active_tr_sesh_inst.session_number} on Training Repo"
      @all_cardio_bouts_this_session = cardio_bouts_current_session
    else
      flash[:info_1] = "You do not have any active training sessions.<br>You can review previous sessions here."
      redirect_to training_sessions_path
    end
  end

  def new
    if !user_is_active?
      redirect_to inactive_path
    elsif @active_tr_sesh_inst
      @new_session_cardio_bout = SessionCardioBout.new(training_session: @active_tr_sesh_inst, cardio_type_id: params[:cardio_type_id])
      @cardio_types = CardioType.all.sort_by{|x| x.name}
      @cardio_methods = CardioMethod.all.sort_by{|x| x.name}
      if params[:cardio_type_id]
        @new_session_cardio_bout.cardio_type_id = params[:cardio_type_id]
        if params[:distance]
          @new_session_cardio_bout.distance = params[:distance]
        end
        if params[:cardio_method_id]
          @new_session_cardio_bout.cardio_method_id = params[:cardio_method_id].to_i
        end
        if params[:time].to_i > 1
          @new_session_cardio_bout.time = params[:time].to_i
        end
      end
      @title = "Adding a New Cardio Bout to #{current_user.first_name.capitalize}'s #{ordinal(@active_tr_sesh_inst.session_number)} Session on Training Repo"
    else
      flash[:info_1] = "You do not have any active training sessions.<br>You must first start a new training session before adding sets."
      redirect_to my_tr_path
    end
  end


  def create
    @new_session_cardio_bout = SessionCardioBout.new(approved_session_cardio_bout_params)

    if @new_session_cardio_bout.save
      redirect_to session_cardio_bouts_path #(anchor: "set-#{@new_session_cardio_bout.id}")
    else
      flash[:warning_1] = "Something went sideways..."
      render :new
    end
  end


  # def call_active_training_session_instance
  #   @active_tr_sesh_inst = TrainingSession.active_session_instance(current_user.id)
  # end

  def approved_session_cardio_bout_params
    params.require(:session_cardio_bout).permit(:distance, :time, :cardio_type_id, :notes, :training_session_id, :cardio_method_id)
  end

  private

  def cardio_bouts_current_session
    SessionCardioBout.where(training_session: @active_tr_sesh_inst)
  end

end
