class WelcomeController < ApplicationController

  def index
    @twitter_user = TwitterUser.new()
    @user_info = Vimeo::Simple::User.info("user45767522")
    @user_videos = Vimeo::Simple::User.videos("user45767522")

    render :index
  end
end
