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


end
