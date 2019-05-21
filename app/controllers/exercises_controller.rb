class ExercisesController < ApplicationController

  def index
    @exercises = Exercise.order(:name).where("lower(name) like ?", "%#{params[:term].downcase}%")
    render json: @exercises.map(&:name)
  end

end
