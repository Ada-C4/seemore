class SessionsController < ApplicationController
  before_action :require_login, except: [:new, :create]
  skip_before_filter :verify_authenticity_token, only: [:create]

  def new
  end

  def create
   auth_hash = request.env['omniauth.auth']
   if auth_hash["uid"]
     @user = User.find_or_create_from_omniauth(auth_hash)
     if @user
       session[:user_id] = @user.id
       redirect_to feed_path, notice: "Welcome to CurateTV. Happy Curating!"
     else
       redirect_to root_path, notice: "Failed to save the user."
     end
   else
     redirect_to root_path, notice: "Failed to authenticate."
   end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You've logged out. See you next time."
  end
end
