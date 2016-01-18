
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  skip_before_filter :verify_authenticity_token, :only => :create
  before_action :current_user

  def current_user
    if session[:user_id] && !!User.exists?(session[:user_id])
      @current_user ||= User.find(session[:user_id])
    end
  end

  def require_login
    if current_user.nil?
      flash[:error] = "You must be logged in to view this section"
      redirect_to root_path
    end
  end

end
