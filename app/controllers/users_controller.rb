class UsersController < ApplicationController

  def twitter
    Seemore::Application.config.twitter
  end

  def vimeo
    Seemore::Application.config.vimeo
  end

  def show
    #Seemore::Application.config.twitter
    @sample_stories = twitter.user_timeline("Schwarzenegger")
    @vimeo_stories = Vimeo::Simple::User.videos("15397797")
  end

end
