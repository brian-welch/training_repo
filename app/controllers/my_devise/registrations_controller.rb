
class MyDevise::RegistrationsController < Devise::RegistrationsController
  before_action :sanitize_new_user_params

  def new
    super
  end

  def create
  	super

    if resource.save
      # changes units from unit standard to a hash
      if new_user_assoc_params[:units_of_measure] = "metric"
        resource.weight_units("kg")
        resource.distance_units("km")
      else
        resource.weight_units("lbs")
        resource.distance_units("miles")
      end

      resource.save!

      # populates weight table if user is saved correctly
      new_user_weight = UserWeight.new(weight: new_user_assoc_params[:weight], user_id: resource.id)
      # new_user_weight.user_id = resource.id
      new_user_weight.save
    end

  end

  def update
    super
  end

  private

  def sanitize_new_user_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :gender_id, :birthdate, :role_id, :weight_units, :distance_units])
  end

  def new_user_assoc_params
    params.require(:user).permit(:weight, :units_of_measure)
  end

end





