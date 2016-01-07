class WelcomeController < ApplicationController

  def index
    @twitter_user = TwitterUser.new()
  end
end
