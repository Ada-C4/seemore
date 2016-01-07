class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    auth_hash = request.env['omniauth.auth']
    @spy = Spy.find_or_create_from_omniauth(auth_hash)
    session[:spy_id] = @spy.id
    redirect_to root_path
  end
end
