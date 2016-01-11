class WelcomeController < ApplicationController
  before_action :current_user
  include VimeoWrapper

  def index
    if @current_user.nil?
      redirect_to login_path
    else
      @twitter_user = TwitterUser.new()
      @vid = get_video(145516416)
    end
  end
end
