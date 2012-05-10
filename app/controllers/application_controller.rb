class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  # Via http://railscasts.com/episodes/270-authentication-in-rails-3-1
  #
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def require_user
    redirect_to root_path unless current_user.present?
  end
end
