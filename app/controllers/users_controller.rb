class UsersController < ApplicationController

  def twitter
    Seemore::Application.config.twitter
  end

  def vimeo
    Seemore::Application.config.vimeo
  end

  def show
    @sample_stories = twitter.user_timeline("Schwarzenegger")
    @vimeo_stories = Vimeo::Simple::User.videos("15397797")
  end

  def twitter_search
    search_term = params[:search]
    @search_results = twitter.user_search(search_term).take(20)
  end

  def twitter_search_user
    @user_name = params[:id]
    @user_tweets = twitter.user_timeline(@user_name)
  end

  def twitter_subscribe
    @user_name = params[:id]
    @tweets = twitter.user_timeline(@user_name)
    uid = @tweets[0].user.id
    provider = "twitter"
    username = @tweets[0].user.screen_name
    avatar_url = @tweets[0].user.profile_image_url
    subscription = Subscription.find_or_create(uid, provider, username, avatar_url)
    @tweets.each do |tweet|
      Story.create(uid: tweet.id, text: tweet.text, subscription_id: subscription.id, post_time: tweet.created_at)
    end
    redirect_to root_path
  end

  def vimeo_search
    search_term = params[:search]
    @vimeo_results = Vimeo::Simple::User.info(search_term)
  end
end
