class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :require_login
  before_action :current_user

  def current_user
   @current_user ||= User.find(session[:user_id]) if session[:user_id]
   rescue ActiveRecord::RecordNotFound
  end

  def require_login
    unless current_user
      flash[:error] = "Login to begin curating."
      redirect_to new_session_path
    end
  end
end
