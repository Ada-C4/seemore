class Subscription < ActiveRecord::Base
  validates :username, :uid, :provider, presence:true
  has_many :stories
  has_and_belongs_to_many :users

  def self.find_or_create(uid, provider, username, avatar_url)
    subscription = self.find_by(uid: uid, provider: provider)
    if !subscription.nil?
      #subscription found continue on with your life
      return subscription
    else
      #create a new subscription
      subscription = Subscription.new
      subscription.uid = uid
      subscription.provider = provider
      subscription.username = username
      subscription.avatar_url = avatar_url
      if subscription.save
        return subscription
      else
        return nil
      end
    end
  end

  def self.find(uid, provider)
    subscription = self.find_by(uid: uid, provider: provider)
    if !subscription.nil?
      #subscription found continue on with your life
      return subscription
    else
      return nil
    end
  end

  def self.update_stories
    twitter = Seemore::Application.config.twitter
    subscriptions = Subscription.all
    subscriptions.each do |subscription|
      if subscription.provider == "twitter"
        @tweets = twitter.user_timeline(subscription.username)
        @tweets.each do |tweet|
          response = Story.find_story?(tweet.id, subscription.id)
          if response == true
            break
          else
            post_time = DateTime.parse(tweet.created_at.to_s)
            Story.create_new_story(tweet.id, tweet.text, subscription.id, post_time)
          end
        end
      end
    end
  end
end
