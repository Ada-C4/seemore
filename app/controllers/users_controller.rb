class UsersController < ApplicationController

  def show
    @videos = @current_user.videos
  end

end
