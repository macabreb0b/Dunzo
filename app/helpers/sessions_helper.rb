module SessionsHelper
  def current_user
    return nil unless session[:token]
    @current_user ||= User.find_by(token: session[:token])
  end

  def logged_in?
    !!current_user
  end
end
