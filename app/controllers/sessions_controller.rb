class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:create]
  after_action :update_feed, only: [:create]

  def create
    auth = request.env['omniauth.auth']

    # Find an identity here
    @identity = Identity.find_with_omniauth(auth)

    if @identity.nil?
      # If no identity was found, create a brand new one here
      @identity = Identity.create_with_omniauth(auth)
    end

    # CURRENTLY, all this is linking the identity to the user, not linking any feeds or follower handles
    if signed_in?
      if @identity.user == current_user
        # Occurs when a user is logged in, and tries to link via a provider they've already linked before
        redirect_to root_path, notice: "Already linked that account!"
      else
        # Linking an identity with the signed in user. Identity hasn't previously been linked with user.
        # This also merges the handles each user account follows
        current_user.merge_user_accounts(@identity.user) unless @identity.user.nil?

        @identity.user = current_user
        @identity.save
        redirect_to root_path, notice: "Successfully linked that account!"
      end
    else
      # not signed in
      if @identity.user.present?
        # user has signed in to site before, our application can find the identity and it is already associated with a user in our database.
        #this sets the session
        self.current_user = @identity.user
        redirect_to root_path, notice: "Signed in!"
      else
        # user has not signed in to the site with either account (twitter or vimeo); it's a completely new user.
        @user = User.create_with_omniauth(auth["info"])
        @identity.user = @user
        @identity.save
        self.current_user = @identity.user
        redirect_to root_path, notice: "Thanks for signing up!"
      end
    end
  end

  def destroy
    self.current_user = nil
    redirect_to root_path, notice: "Signed out!"
  end
end
