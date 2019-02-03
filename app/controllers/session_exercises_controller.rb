class SessionExercisesController < ApplicationController
  def new
    sesh_num = Session.where(open: true, user_id: current_user.id).last.session_number
    @title = "New Exercise on #{current_user.first_name.capitalize}'s Session Number #{sesh_num} in Training Repo"
  end

  def update
  end

  private
end
