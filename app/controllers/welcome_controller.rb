class WelcomeController < ApplicationController

  def index
    @twitter_user = TwitterUser.new()


    render :index
  end
end
