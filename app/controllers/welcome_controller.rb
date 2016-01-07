class WelcomeController < ApplicationController
  def index
    if current_user
      @media = current_user.media
    # if not logged in:
      # display sign in/sign up form
    end
  end
end
