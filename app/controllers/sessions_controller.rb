class SessionsController < ApplicationController
  def index
    @title = "#{current_user.first_name.capitalize}'s Session Log on Training Repo"
    @sesh_num = Session.where(open: true, user_id: current_user.id) ? Session.where(open: true, user_id: current_user.id).last.session_number : 0
  end

  def show
  end

  def create
  end

  def update
  end
end
