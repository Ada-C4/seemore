class UsersController < ApplicationController

  def twitter
    Seemore::Application.config.twitter
  end

  def show
    Seemore::Application.config.twitter
    @sample_stories = twitter.user_timeline("Schwarzenegger")
  end
end
