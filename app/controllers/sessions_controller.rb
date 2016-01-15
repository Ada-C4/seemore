class SessionsController < ApplicationController
  #this line is for the omniauth developer strategy login.
  skip_before_filter :verify_authenticity_token, only: :create
  skip_before_action :require_login, only: [:new, :create, :destroy]

  def create
    #can sign in with twitter or vimeo
    auth_hash = request.env['omniauth.auth']
    if auth_hash["uid"]
      @user = User.find_or_create_from_omniauth(auth_hash)
      if @user
        session[:user_id] = @user.id
      else
        flash[:notice] = "Failed to save the user"
      end
    else
      flash[:notice] = "Failed to authenticate"
    end
    redirect_to root_path
  end

  def new; end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end
