class WelcomeController < ApplicationController
  before_action :current_user
  include VimeoHelper

  def index
    @twitter_user = TwitterUser.new()
    @vid =
    HTTParty.get( "https://vimeo.com/api/oembed.json?url=https%3A//vimeo.com/102805992&maxwidth=#{VIMEO_MAX_WIDTH}&maxheight=#{VIMEO_MAX_HEIGHT}", headers: {"Authorization" => vimeo_auth, 'Accept' => 'application/json' }, format: :json).parsed_response
  end

end
