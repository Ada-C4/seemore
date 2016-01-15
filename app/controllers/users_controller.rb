require 'will_paginate/array'
class UsersController < ApplicationController

  before_action :require_login, only: [:twitter_search, :twitter_search_user, :vimeo_search, :vimeo_search_user, :twitter_subscribe, :vimeo_subscribe]

  def twitter
    Seemore::Application.config.twitter
  end

  def vimeo
    Seemore::Application.config.vimeo
  end

  def show
    # Updates existing subscriptions with new content
    Subscription.update_stories

    @stories = []
    if !@current_user
      @stories = UsersHelper.default_content
    else
      @stories = UsersHelper.user_content(@current_user)
    end
    @stories = @stories.sort_by! { |story| story[:post_time] }.reverse!
    @stories = @stories.paginate(:page => params[:page], :per_page => 15)
  end

  def twitter_search
    search_term = params[:search]
    @search_results = twitter.user_search(search_term).take(10)
  end

  def instagram_search
    client = Instagram.client(:access_token => ENV["INSTAGRAM_ACCESS_TOKEN"])
    search_term = params[:search]
    @search_results = client.user_search(search_term)
  end

  def twitter_search_user
    subscriptions = @current_user.subscriptions
    @user_name = params[:id]
    @user_tweets = twitter.user_timeline(@user_name)
    uid = @user_tweets[0].user.id
    subscription = Subscription.find(uid, "twitter")
    if !subscriptions.include? subscription
      @button = true
    end
  end

  def instagram_search_user
    subscriptions = @current_user.subscriptions
    @user_name = params[:id]
    @results = HTTParty.get("https://www.instagram.com/#{@user_name}/media/")
    @results = @results["items"]
    uid = @results[0]["user"]["id"]
    subscription = Subscription.find(uid, "instagram")
    if !subscriptions.include? subscription
      @button = true
    end
  end

  def twitter_subscribe
    twitter_user = params[:id]
    tweets, uid, provider, username, avatar_url = UsersHelper.twitter_subscription_info(twitter_user)
    subscription = Subscription.find_or_create(uid, provider, username, avatar_url)

    if !@current_user.subscriptions.include? subscription
      @current_user.subscriptions << subscription
    end

    tweets.each do |tweet|
      uid, text, subscription_id, post_time = UsersHelper.tweet_to_story(tweet, subscription)
      Story.find_or_create(uid, text, subscription_id, post_time)
    end
    redirect_to root_path
  end

  def instagram_subscribe
    instagram_user = params[:id]
    grams, uid, provider, username, avatar_url = UsersHelper.instagram_subscription_info(instagram_user)
    subscription = Subscription.find_or_create(uid, provider, username, avatar_url)

    if !@current_user.subscriptions.include? subscription
      @current_user.subscriptions << subscription
    end

    grams.each do |gram|
      uid, text, url, subscription_id, post_time = UsersHelper.gram_to_story(gram, subscription)
      Story.find_or_create(uid, text, url, subscription_id, post_time)
    end
    redirect_to root_path
  end


  def vimeo_subscribe
    vimeo_user = params[:id]
    videos, uid, provider, username, avatar_url = UsersHelper.vimeo_subscription_info(vimeo_user)
    subscription = Subscription.find_or_create(uid, provider, username, avatar_url)

    if !@current_user.subscriptions.include? subscription
      @current_user.subscriptions << subscription
    end
    videos.each do |video|
      video_uid, text, url, subscription_id, post_time = UsersHelper.video_to_story(video, subscription)
      Story.find_or_create(video_uid, text, url, subscription_id, post_time)
    end
    redirect_to root_path
  end

  def vimeo_search
    vimeo_env = ENV["VIMEO_ACCESS_TOKEN"]
    search_term = params[:search]
    results = HTTParty.get("https://api.vimeo.com/users?page=1&per_page=25&query=#{search_term}", headers: {"Authorization" => "bearer #{vimeo_env}", 'Accept' => 'application/json' }, format: :json).parsed_response
      if results["total"] == 0
        flash.now[:error] = "No results matched your search."
      else
        @vimeo_results = results["data"]
      end
      return @vimeo_results
  end

  def vimeo_search_user
    subscriptions = @current_user.subscriptions
    @vimeo_user = params[:id]
    @results = UsersHelper.vimeo_call_videos(@vimeo_user)
    @results = @results["data"]
    subscrip = Subscription.find(@vimeo_user, "vimeo")
      if !subscriptions.include? subscrip
        @button = true
      end
  end
end
