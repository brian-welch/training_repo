class MachinesController < ApplicationController
    before_action :make_machine_json, only: [:new, :create]

  def index
    @title = "A List of All Strength Training Machines in Training Repo's Database"
    all_machine_instances = Machine.all
    @brand_machine_hash = {};
    all_machine_instances.each do |machine|
        if @brand_machine_hash[machine.brand.name].nil?
          @brand_machine_hash[machine.brand.name] = []
          @brand_machine_hash[machine.brand.name] << machine.name
        else
          @brand_machine_hash[machine.brand.name] << machine.name
        end
    end
  end

  def new
    requester_role = current_user.role.name
    if requester_role != "admin"
      if requester_role != "pt"
        flash[:alert] = "You do not have permissions to add new machnines.<br>Please contact the admin or your personal trainer to add machines."
        redirect_to machines_path
      end
    else
      @new_machine = Machine.new
    end
  end

  def create
    @new_machine = Machine.new(approve_machine_params)
    @new_machine.name = @new_machine.name.downcase.strip
    if @new_machine.save
      flash[:notice] = "<u>#{@new_machine.name.split(" ").map{|x| x.capitalize}.join(" ")}</u> by \"#{@new_machine.brand.name}\" has been added to the database!"
      redirect_to machines_path
    else
      flash[:alert] = "Something Went Pair Shaped"
      render :new
    end

  end

  private

  def make_machine_json
    all_machine_hash = Machine.all_machine_hash
    @all_machine_json = all_machine_hash.to_json
  end

  def approve_machine_params
    params.require(:machine).permit(:mech_ad, :brand_id, :name)
  end

end
