class WelcomeController < ApplicationController

  def index
    @twitter_user = TwitterUser.new()
    @instagram = Instagram.user_recent_media("1496836825", {:count => 3})
    @instagram_search = Instagram.user_search('dreedles')
    @instagram_user = Instagram.user("1496836825")
    render :index
  end
end
