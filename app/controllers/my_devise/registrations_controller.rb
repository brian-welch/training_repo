# app/controllers/registrations_controller.rb
class MyDevise::RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
  	super
  	p "\n\n NEW REGISTRATION CONTROLLER\n\n"
    # add custom create logic here
  end

  def update
    super
  end
end 