class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_spy
  helper_method :twitter

  def current_spy
    @current_spy ||= Spy.find(session[:spy_id]) if session[:spy_id]
  end
end
