class VimeoUsersController < ApplicationController
  def create
  screen_name = strong_params[:screen_name]
    # find user using Vimeo API
    new_vimeo_user = $client.user(screen_name)
    # create hash using info from Vimeo API
    vimeo_user_hash = {
      vimeo_id: new_vimeo_user.id,
      screen_name: new_vimeo_user.ßscreen_name,
      name: new_vimeo_user.name,
      description: new_vimeo_user.description,
      location: new_vimeo_user.location,
      uri: new_vimeo_user.uri,
      profile_image_uri: new_vimeo_user.profile_image_uri
    }
    @vimeo_user = VimeoUser.create(vimeo_user_hash)
    redirect_to :root
  end

  $client = Vimeo::REST::Client.new do |config|
    config.client_id    = ENV["VIMEO_CLIENT_ID"]
    config.client_secret = ENV["VIMEO_CLIENT_SECRETS"]
    config.access_token = ENV["VIMEO_ACCESS_TOKEN"]
  end

  class VimeoUserFetcher
    include HTTParty
    base_uri 'https://api.vimeo.com'

    # attr_reader:

    def initialize(u, p)
      @auth = {username: u, password: p}
    end

    def search_user(username)
      results = HTTParty.get("/users?page=1&per_page=25&query=#{search_term}&fields=uri,name,bio,pictures",
      headers: {"Authorization" => "bearer #{access_token}", 'Accept' => 'application/json' }, format: :json).parsed_response
     if results["total"] == 0
       flash.now[:error] = "We couldn't find that user."
     else
       @results = results["data"]
    end

    def user_info

    end

    private

    def access_token
      ENV["VIMEO_ACCESS_TOKEN"]
    end
  end

  private

  def strong_params
    params.require(:vimeo_user)
  end
end
