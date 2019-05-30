class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :about, :your_privacy]

  def home
  end

  def about
  end

  def inactive
    if user_is_active?
      flash[:notice] = "Your account is currently active!"
      redirect_to my_tr_path
    end
  end

  def your_privacy
  end

  def contact_us
  end

end
