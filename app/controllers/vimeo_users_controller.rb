class VimeoUsersController < ApplicationController
  before_action :current_user
  include VimeoHelper

  def subscribe
    @vim_uri = params[:uri]
    if !vimeo_user_exists?
      # if vimeo_user doesn't exist, create vimeo_user and their videos
      create_vimeo_user(@vim_uri)
      create_videos(@vimeo_user)
    end
    @vimeo_user = VimeoUser.find_by(uri: @vim_uri)
    #subscribe to vimeo_user
    @current_user.vimeo_users << @vimeo_user
    redirect_to :root
  end

  private

  def vimeo_user_exists?
    if VimeoUser.find_by(uri: @vim_uri)
      return true
    else
      return false
    end
  end

  def create_vimeo_user(uri)
    new_vimeo_user = get_vimeo_user(uri)
    # create hash using info from Vimeo API
    vimeo_user_hash = {
      uri: new_vimeo_user["uri"],
      name: new_vimeo_user["name"],
      description: new_vimeo_user["bio"],
      location: new_vimeo_user.location,
      uri: new_vimeo_user.uri,
      profile_image_uri: new_vimeo_user.profile_image_uri
    }
    @vimeo_user = VimeoUser.create(vimeo_user_hash)
  end

  def create_tweets(vimeo_user)
    # grab tweets from Vimeo API - most recent 20 tweets by default
    tweets_array = $client.user_timeline(vimeo_user.vimeo_id.to_i)
    # turn each tweet into a Tweet object
    tweets_array.each do |tweet|
      tweet_hash = {
        vimeo_id: tweet.id.to_s,
        text: tweet.text,
        uri: tweet.uri,
        vimeo_user_id: vimeo_user.id
      }
      Tweet.create(tweet_hash)
    end
  end
end
