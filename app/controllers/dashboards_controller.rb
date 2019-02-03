class DashboardsController < ApplicationController

  def index
    @title = "My Training Repo Dashboard"
    @user = current_user
  end

  private

end
