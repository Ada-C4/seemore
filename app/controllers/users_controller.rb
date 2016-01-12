class UsersController < ApplicationController

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
    @stories.sort_by! { |story| story[:post_time] }.reverse!
  end

  def twitter_search
    search_term = params[:search]
    @search_results = twitter.user_search(search_term).take(10)
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

  def twitter_subscribe
    twitter_user = params[:id]
    tweets, uid, provider, username, avatar_url = UsersHelper.twitter_subscription_info(twitter_user)
    subscription = Subscription.find_or_create(uid, provider, username, avatar_url)

    if !@current_user.subscriptions.include? subscription
      @current_user.subscriptions << subscription
    end

    tweets.each do |tweet|
      uid = tweet.id
      text = tweet.text
      subscription_id = subscription.id
      post_time = DateTime.parse(tweet.created_at.to_s)
      Story.find_or_create(uid, text, subscription_id, post_time)
    end
    redirect_to root_path
  end

  def vimeo_subscribe
    @vimeo_user = params[:id]
    vimeo_env = ENV["VIMEO_ACCESS_TOKEN"]
    provider = "vimeo"
    video_results = HTTParty.get("https://api.vimeo.com/users/#{@vimeo_user}/videos", headers: {"Authorization" => "bearer #{vimeo_env}", 'Accept' => 'application/json' }, format: :json).parsed_response
    user_results = HTTParty.get("https://api.vimeo.com/users/#{@vimeo_user}", headers: {"Authorization" => "bearer #{vimeo_env}", 'Accept' => 'application/json' }, format: :json).parsed_response
    #binding.pry
    uid = @vimeo_user
    username = user_results["name"]
    avatar_url = user_results["pictures"]["sizes"][1]["link"]
    # @videos = search["metadata"]["connections"]["videos"]["options"]
    @videos = video_results["data"]
    subscription = Subscription.find_or_create(uid, provider, username, avatar_url)
    user = User.find(session[:user_id])
    if !user.subscriptions.include? subscription
      user.subscriptions << subscription
    end
    @videos.each do |video|
      video_uid = video["uri"].byteslice(8..-1)
      text = video["name"]
      url = video["link"]
      subscription_id = subscription.id
      post_time = DateTime.parse(video["created_time"].to_s)
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
  end

  def vimeo_search_user
    subscriptions = @current_user.subscriptions
    @user_name = params[:id]
  end

end
