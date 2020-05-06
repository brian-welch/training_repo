class TrainingSessionsController < ApplicationController
  include ApplicationHelper
  include CalculationsHelper

  before_action :set_training_session, only: [:show]

  def index
    @title = "#{current_user.first_name.capitalize}'s Session Histroy on Training Repo"
    @all_my_sessions = TrainingSession.where(user: current_user).order("created_at ASC")
    @all_my_sessions_month_hash = @all_my_sessions.group_by {|sesh| [sesh.created_at.month, sesh.created_at.year]}
    @all_my_sessions_date_hash = @all_my_sessions.group_by {|sesh| sesh.created_at.strftime("%F")} # (&:created_at)
  end

  def new
    if !user_is_active?
      redirect_to inactive_path
    elsif TrainingSession.active_session_number(current_user.id)
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
    if @training_session.nil?
      flash[:alert] = "This was not a link to a valid training session."
      redirect_to training_sessions_path
    else
      @title = "#{current_user.first_name.capitalize}'s Training Session Details on Training Repo"

      # IDEA: in application controller, after signin do an after_action method to cache all user sets
      session_set_inst_arr = SessionSet.where(:training_session => @training_session).sort_by{|set| set.created_at}

      @session_date         = @training_session.created_at
      @session_duration     = get_session_duration(@training_session)
      @total_weight_session = total_weight_lifted_in_sets_array(session_set_inst_arr)
      @weight_per_hour      = weight_lifted_per_hour_during_session(@training_session, @total_weight_session)


      session_set_inst_arr.map!.with_index {|set, i| x = []; x << (i + 1); x << set}

      @exercise_hash = session_set_inst_arr.group_by {|order,set| [set.exercise, set.resistance_method, get_machine_or_pulley_or_neither(set)]}

    end
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
    params.require(:training_session).permit(:user_id, :session_strategy_id, :notes)
  end

  # def mechanical_deductions(set)
  #   if !set.machine.nil?
  #     (set.machine.mech_ad * set.machine.pulley_count * set.pulley_count)
  #   else
  #     return set.pulley_count
  #   end
  # end

  def set_training_session
    @training_session = TrainingSession.where("id = ? AND user_id = ? AND open = ?", params[:id], current_user.id, false)[0]
  end

  def get_machine_or_pulley_or_neither(set)
    resist_name = set.resistance_method.name.downcase
    if resist_name.include?("machine")
      return "#{proper_string(set.machine.name)} by #{proper_string(set.machine.brand.name)}"
    elsif resist_name.include?("cable") || resist_name.include?("crossover")
      return "#{set.pulley_count} #{set.pulley_count > 1 ? 'Pulleys' : 'Pulley'}"
    else
      return nil
    end
  end

end
