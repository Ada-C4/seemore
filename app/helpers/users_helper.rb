module UsersHelper
  def self.default_content
    stories = []
    stories.push(Story.where(subscription_id: 1))
    stories.push(Story.where(subscription_id: 2))
    stories.flatten!
    return stories
  end  

  def self.user_content(user)
    stories = []
    user.subscriptions.each do |subscription|
      subscription.stories.each do |story|
        stories.push(story)
      end
    end
    return stories
  end

  def self.twitter_subscription_info(user_name)
    twitter = Seemore::Application.config.twitter
    tweets = twitter.user_timeline(user_name)
    uid = tweets[0].user.id
    provider = "twitter"
    username = tweets[0].user.screen_name
    avatar_url = tweets[0].user.profile_image_url
    return tweets, uid, provider, username, avatar_url
  end

  def self.instagram_subscription_info(user_name)
    results = HTTParty.get("https://www.instagram.com/#{user_name}/media/")
    results = results["items"]
    uid = results[0]["user"]["id"]
    provider = "instagram"
    username = user_name
    avatar_url = results[0]["user"]["profile_picture"]
    return results, uid, provider, username, avatar_url
  end

  def self.vimeo_call_videos(vimeo_user)
    vimeo_env = ENV["VIMEO_ACCESS_TOKEN"]
    return HTTParty.get("https://api.vimeo.com/users/#{vimeo_user}/videos", headers: {"Authorization" => "bearer #{vimeo_env}", 'Accept' => 'application/json' }, format: :json).parsed_response
  end

  def self.vimeo_subscription_info(vimeo_user)
    vimeo_env = ENV["VIMEO_ACCESS_TOKEN"]
    video_results = HTTParty.get("https://api.vimeo.com/users/#{vimeo_user}/videos", headers: {"Authorization" => "bearer #{vimeo_env}", 'Accept' => 'application/json' }, format: :json).parsed_response
    user_results = HTTParty.get("https://api.vimeo.com/users/#{vimeo_user}", headers: {"Authorization" => "bearer #{vimeo_env}", 'Accept' => 'application/json' }, format: :json).parsed_response
    provider = "vimeo"
    uid = vimeo_user
    username = user_results["name"]
    avatar_url = user_results["pictures"]["sizes"][1]["link"]
    videos = video_results["data"]
    return videos, uid, provider, username, avatar_url
  end

  def self.tweet_to_story(tweet, subscription)
    uid = tweet.id
    text = tweet.text
    subscription_id = subscription.id
    post_time = DateTime.parse(tweet.created_at.to_s)
    return uid, text, subscription_id, post_time
  end

  def self.gram_to_story(gram, subscription)
    uid = gram["id"]
    if !gram["caption"].nil?
      text = gram["caption"]["text"]
    else
      text = nil
    end
    url = gram["images"]["standard_resolution"]["url"]
    subscription_id = subscription.id
    post_time = gram["created_time"]
    post_time = DateTime.strptime(post_time,'%s')
    return uid, text, url, subscription_id, post_time
  end

  def self.video_to_story(video, subscription)
    video_uid = video["uri"].byteslice(8..-1)
    text = video["name"]
    url = video["link"]
    subscription_id = subscription.id
    post_time = DateTime.parse(video["created_time"].to_s)
    return video_uid, text, url, subscription_id, post_time
  end
end
