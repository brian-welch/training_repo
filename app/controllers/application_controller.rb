class ApplicationController < ActionController::Base
  #before_action :store_user_location!, if: :storable_location?

  before_action :authenticate_user!
  before_action :get_user_units

  add_flash_types   :success_1,  :success_2,  :success_3,  :success_4,
                    :info_1,     :info_2,     :info_3,     :info_4,
                    :warning_1,  :warning_2,  :warning_3,  :warning_4,
                    :danger_1,   :danger_2,   :danger_3,   :danger_4,
                    :special_1,  :special_2,  :special_3,  :special_4

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

  def user_is_active?
    return current_user.active
  end

  def get_user_units
    # sets weight units for a signed in user
    user_signed_in? ? @units = current_user.units_of_measure :  @units = "kg/lbs"
    @weight_units = current_user.units_of_measure == "metric" ? "kg" : "lbs" if user_signed_in?
    @distance_units = current_user.units_of_measure == "metric" ? "km" : "miles" if user_signed_in?
  end

end

