class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :current_spy

  helper_method :current_spy

  def current_spy
    @current_spy ||= Spy.find(session[:spy_id]) if session[:spy_id]
  end

  def require_spy
    if !logged_in?
      flash[:error] = "Please log in to view this section"
      redirect_to root_path
    end
  end

  def logged_in?
    !current_spy.nil?
  end
end
