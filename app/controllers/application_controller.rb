class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper

  def login!(user)
    session[:token] = user.reset_token!
  end

  def logout!
    session[:token] = nil
  end

  def check_logged_in(user_id)
    if user_id != current_user.id
      flash[:errors] = "You do not have permission to see that page."
      redirect_to :back and return
    end
  end
end
