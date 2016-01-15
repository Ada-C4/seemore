class Tweet < ActiveRecord::Base

  def self.find_or_create_tweets(creator)
    all_tweets = creator.get_tweets
    all_tweets.each do |tweet|
    existing_tweet = self.find_by(uid: tweet.id)
      if existing_tweet.nil?
        tweet = Tweet.create(
        creator_id: creator.id,
        posted_at:  tweet.created_at,
        uid: tweet.id
        )
      end
    end
  end
end
