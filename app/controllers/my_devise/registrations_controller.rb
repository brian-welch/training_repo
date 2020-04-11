
class MyDevise::RegistrationsController < Devise::RegistrationsController
  before_action :sanitize_new_user_params

  def new
    super
  end

  def create
  	super

    if resource.save

      new_user_weight = UserWeight.new(new_user_weight_param)
      new_user_weight.user_id = resource.id
      new_user_weight.save


    end
  end

  def update
    super
  end

  protected

  def sanitize_new_user_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :gender_id, :birthdate, :role_id, :units_of_measure])
  end

  def new_user_weight_param
    params.require(:user).permit(:weight)
  end


end  