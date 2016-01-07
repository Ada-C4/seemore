class WelcomeController < ApplicationController

  def index
    @me = $client.user("kdefliese")
    @you = $client.user("DreyDavis")
    render :index
  end
end
