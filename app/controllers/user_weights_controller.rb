class UserWeightsController < ApplicationController

  def show
  	my_user_id? ? @content = "It's your ID" : @content = "Shameful... trying to see someone else's weight"
  end

  def new
  end

  private

  def my_user_id?
  	current_user.id == params[:id].to_i
  end



end
