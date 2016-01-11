class WelcomeController < ApplicationController
  before_action :current_user
  include VimeoHelper

  def index
    @twitter_user = TwitterUser.new()
    @vid = get_video(145516416)
  end

end
