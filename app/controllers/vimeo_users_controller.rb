class VimeoUsersController < ApplicationController
  before_action :current_user

  def subscribe
    @screen_name = params[:screen_name]
    if !vimeo_user_exists?
      # if vimeo_user doesn't exist, create vimeo_user and their videos
      create_vimeo_user(@screen_name)
      create_tweets(@vimeo_user)
    end
    @vimeo_user = TwitterUser.find_by(screen_name: @screen_name)
    #subscribe to vimeo_user
    @current_user.vimeo_users << @vimeo_user
    redirect_to :root
  end

  private

  def vimeo_user_exists?
    if TwitterUser.find_by(screen_name: @screen_name)
      return true
    else
      return false
    end
  end

  def create_vimeo_user(screen_name)
    new_vimeo_user = $client.user(screen_name)
    # create hash using info from Twitter API
    vimeo_user_hash = {
      vimeo_id: new_vimeo_user.id,
      screen_name: new_vimeo_user.screen_name,
      name: new_vimeo_user.name,
      description: new_vimeo_user.description,
      location: new_vimeo_user.location,
      uri: new_vimeo_user.uri,
      profile_image_uri: new_vimeo_user.profile_image_uri
    }
    @vimeo_user = TwitterUser.create(vimeo_user_hash)
  end

  def create_tweets(vimeo_user)
    # grab tweets from Twitter API - most recent 20 tweets by default
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
