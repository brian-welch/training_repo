class MachinesController < ApplicationController
    before_action :make_machine_json, only: [:new, :create]

  def index
    @title = "A List of All Strength Training Machines in Training Repo's Database"
    @brand_machine_hash = Machine.all.group_by {|x| x.brand.name}
  end

  def new
    requester_role = current_user.role.name
    if !user_is_active?
      redirect_to inactive_path
    elsif requester_role != "admin"
      if requester_role != "pt"
        flash[:warning_1] = "You do not have permissions to add new machnines.<br>Please contact the admin or your personal trainer to add machines."
        redirect_to machines_path
      end
    else
      @new_machine = Machine.new
    end
  end

  def create
    @new_machine = Machine.new(approve_machine_params)
    @new_machine.name = proper_string(@new_machine.name.downcase.strip)
    @new_machine.brand = nil if @new_machine.brand.name.downcase == 'placeholder'
    #@new_machine.inherit_weight = 0 if @new_machine.inherit_weight == nil

    if @new_machine.save
      flash[:success_1] = "<u>#{@new_machine.name}</u> by \"#{@new_machine.brand.name}\" has been added to the database!"
      redirect_to machines_path
    else
      if @new_machine.brand.nil?
        flash[:info_1] = "'Placeholder' is not a real brand."
      else
        flash[:warning_1] = "Something Went Pair Shaped"
      end
      render :new
    end

  end

  private

  def make_machine_json
    all_machine_hash = Machine.all_machine_hash
    @all_machine_json = all_machine_hash.to_json
  end

  def approve_machine_params
    params.require(:machine).permit(:mech_ad, :pulley_count, :brand_id, :name, :inherit_weight)
  end

end
