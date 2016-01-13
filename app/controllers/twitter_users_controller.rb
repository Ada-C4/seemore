require 'pry'
class TwitterUsersController < ApplicationController
  before_action :current_user

  def subscribe
    @screen_name = params[:screen_name]
    if twitter_user_protected?
      flash[:error] = "That user is protected; you cannot subscribe to their tweets."
    else
      if !twitter_user_exists?
        # if twitter_user doesn't exist, create twitter_user and their tweets
        create_twitter_user(@screen_name)
        create_tweets(@twitter_user)
      end
      @twitter_user = TwitterUser.find_by(screen_name: @screen_name)
      # binding.pry
      if @current_user.twitter_users.include?(@twitter_user)
        #if current_user is already subscribed to this twitter_user, show error
        flash[:error] = "You are already subscribed to this user."
      else
        # subscribe current_user to twitter_user
        @current_user.twitter_users << @twitter_user
      end
    end
    redirect_to :root
  end

  def unsubscribe
    @screen_name = params[:screen_name]
    @twitter_user = TwitterUser.find_by(screen_name: @screen_name)
    @current_user.twitter_users.delete(@twitter_user)
    redirect_to :subscriptions
  end

  private

  def twitter_user_exists?
    if TwitterUser.find_by(screen_name: @screen_name)
      return true
    else
      return false
    end
  end

  def twitter_user_protected?
    $client.user(@screen_name).protected?
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

  def create_tweets(twitter_user)
    # grab tweets from Twitter API - most recent 20 tweets by default
    tweets_array = $client.user_timeline(twitter_user.twitter_id.to_i)
    # turn each tweet into a Tweet object
    tweets_array.each do |tweet|
      tweet_hash = {
        twitter_id: tweet.id.to_s,
        text: tweet.text,
        uri: tweet.uri,
        twitter_user_id: twitter_user.id,
        provider_created_at: tweet.created_at.to_datetime,
        embed: $client.oembed(tweet.id.to_s).html
      }
      Tweet.create(tweet_hash)
    end
  end

end
