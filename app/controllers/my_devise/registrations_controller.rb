class MyDevise::RegistrationsController < Devise::RegistrationsController
  before_action :sanitize_new_user_params

  def new
    super
  end

  def create
  	super
  	puts 
  	puts
  	p resource
  	puts
  	puts
  	

    # add custom create logic here, I'm going to save one of the params to another table eventually
  end

  def update
    super
  end

  protected

  def sanitize_new_user_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :gender_id, :birthdate, :weight, :role_id, :units_of_measure])
  end


  def approved_new_user_params
    params.require(:user).permit(:first_name, :last_name, :gender_id, :birthdate, :weight, :units_of_measure, :role_id)
  end

end  