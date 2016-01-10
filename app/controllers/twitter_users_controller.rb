require 'pry'
class TwitterUsersController < ApplicationController
  before_action :current_user

  def subscribe
    @screen_name = params[:screen_name]
    if !twitter_user_exists?
      create_twitter_user(@screen_name)
      # create new tweets
    end
    @twitter_user = TwitterUser.find_by(screen_name: @screen_name)
    #subscribe to twitter_user
    @current_user.twitter_users << @twitter_user
    redirect_to :root
  end

  private

  def strong_params
    params.require(:twitter_user).permit(:screen_name)
  end

  def twitter_user_exists?
    if TwitterUser.find_by(screen_name: @screen_name)
      return true
    else
      return false
    end
  end

  def create_twitter_user(screen_name)
    new_twitter_user = $client.user(screen_name)
    # create hash using info from Twitter API
    twitter_user_hash = {
      twitter_id: new_twitter_user.id,
      screen_name: new_twitter_user.screen_name,
      name: new_twitter_user.name,
      description: new_twitter_user.description,
      location: new_twitter_user.location,
      uri: new_twitter_user.uri,
      profile_image_uri: new_twitter_user.profile_image_uri
    }
    @twitter_user = TwitterUser.create(twitter_user_hash)
  end

  def create_tweets
  end

end
