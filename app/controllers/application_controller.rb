class ApplicationController < ActionController::Base
  #before_action :store_user_location!, if: :storable_location?

  before_action :authenticate_user!
  before_action :active_session?
  before_action :get_user_units

  add_flash_types :just_saved

  def after_sign_in_path_for(resource_or_scope)
    # stored_location_for(resource_or_scope) || super
    my_tr_path
  end

  def ordinal(n)
    ending = case n % 100
             when 11, 12, 13 then 'th'
             else
               case n % 10
               when 1 then 'st'
               when 2 then 'nd'
               when 3 then 'rd'
               else 'th'
               end
             end

    "#{n}#{ending}"
  end

  def proper_string(string)
    return string.split(" ").map{|x| x.capitalize}.join(" ")
  end

  private

  # def storable_location?
  #   request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  # end
  # def store_user_location!
  #   # :user is the scope we are authenticating
  #   store_location_for(:user, request.fullpath)
  # end

  def user_is_active?
    return current_user.active
  end

  def active_session?
    if user_signed_in?
      current_session_arr = TrainingSession.active_session_call(current_user)
      @current_session = current_session_arr[0]
      @is_active_session = current_session_arr.count == 0 ? false : true
    else
      @is_active_session = false
    end
  end

  def get_user_units
    user_signed_in? ? @units = current_user.units_of_measure :  @units = "kg/lbs"
  end

end

