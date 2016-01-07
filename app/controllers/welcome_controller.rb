class WelcomeController < ApplicationController

  def index
    @me = $client.user("kdefliese")
    @you = $client.user("DreyDavis")
    @instagram = Instagram.user_recent_media("1496836825", {:count => 3})
    render :index
  end
end
