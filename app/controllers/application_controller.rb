class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_before_filter :verify_authenticity_token, :only => :create
  helper_method :current_user, :vim_base_uri, :vimeo_access_token


  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def vim_base_uri
    "https://api.vimeo.com"
  end

  def vimeo_access_token
    ENV["VIMEO_ACCESS_TOKEN"]
  end


end
