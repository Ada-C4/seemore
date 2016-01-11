class UsersController < ApplicationController

  def twitter
    Seemore::Application.config.twitter
  end

  def vimeo
    Seemore::Application.config.vimeo
  end

  def show
    # @sample_stories = twitter.user_timeline("Schwarzenegger")
    # @vimeo_stories = Vimeo::Simple::User.videos("15397797")
    @stories = []
    if !@current_user
      @stories.push(Story.where(subscription_id: 1))
      @stories.push(Story.where(subscription_id: 2))
      @stories.flatten!
    else
      user = User.find(session[:user_id])
      user.subscriptions.each do |subscription|
        subscription.stories.each do |story|
          @stories.push(story)
        end
      end
    end
    @stories.sort_by! { |story| story[:post_time] }.reverse!
  end

  def twitter_search
    search_term = params[:search]
    @search_results = twitter.user_search(search_term).take(20)
  end

  def twitter_search_user
    @curr_user = User.find(session[:user_id])
    subscriptions = @curr_user.subscriptions
    @user_name = params[:id]
    @user_tweets = twitter.user_timeline(@user_name)
    uid = @user_tweets[0].user.id
    subscrip = Subscription.find(uid, "twitter")
    if !subscriptions.include? subscrip
      @button = true
    end
  end

  def twitter_subscribe
    @user_name = params[:id]
    @tweets = twitter.user_timeline(@user_name)
    uid = @tweets[0].user.id
    provider = "twitter"
    username = @tweets[0].user.screen_name
    avatar_url = @tweets[0].user.profile_image_url
    subscription = Subscription.find_or_create(uid, provider, username, avatar_url)
    user = User.find(session[:user_id])
    if !user.subscriptions.include? subscription
      user.subscriptions << subscription
    end
    @tweets.each do |tweet|
      uid = tweet.id
      text = tweet.text
      subscription_id = subscription.id
      post_time = DateTime.parse(tweet.created_at.to_s)
      Story.find_or_create(uid, text, subscription_id, post_time)
      #Story.create(uid: tweet.id, text: tweet.text, subscription_id: subscription.id, post_time: DateTime.parse(tweet.created_at.to_s))
    end
    redirect_to root_path
  end

  def vimeo_search
    vimeo_env = ENV["VIMEO_ACCESS_TOKEN"]
    search_term = params[:search]
    results = HTTParty.get("https://api.vimeo.com/users?page=1&per_page=25&query=#{search_term}&fields=name,bio,pictures,metadata", headers: {"Authorization" => "bearer #{vimeo_env}", 'Accept' => 'application/json' }, format: :json).parsed_response
      if results["total"] == 0
        flash.now[:error] = "No results matched your search."
      else
        @vimeo_results = results["data"]
      end

  end
end
