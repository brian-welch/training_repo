class ApplicationController < ActionController::Base
  before_action :store_user_location!, if: :storable_location?
  before_action :last_page
  # before_action :active_session?
  # The callback which stores the current location must be added before you authenticate the user
  # as `authenticate_user!` (or whatever your resource is) will halt the filter chain and redirect
  # before the location can be stored.
  before_action :authenticate_user!

  add_flash_types :just_saved

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || super
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

  private
  # Its important that the location is NOT stored if:
  # - The request method is not GET (non idempotent)
  # - The request is handled by a Devise controller such as Devise::SessionsController as that could cause an
  #    infinite redirect loop.
  # - The request is an Ajax request as this can lead to very unexpected behaviour.
  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    # :user is the scope we are authenticating
    store_location_for(:user, request.fullpath)
  end

  def last_page
    session[:last_page] = request.env['HTTP_REFERER']
  end

end

