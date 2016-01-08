class WelcomeController < ApplicationController

  def index
    @twitter_user = TwitterUser.new()
    @me = $client.user("kdefliese")
    @you = $client.user("DreyDavis")
    @instagram = Instagram.user_recent_media("1496836825", {:count => 3})
    @instagram_search = Instagram.user_search('dreedles')
    render :index
  end
end
