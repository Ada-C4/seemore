class Tweet < ActiveRecord::Base
  belongs_to :twitter_users
  validates :twitter_id, presence: true
  validates :text, presence: true
  validates :uri, presence:true

  def create_tweets(twitter_user)
    # grab tweets from Twitter API
    tweets_array = $client.user_timeline(twitter_user.twitter_id.to_i)
    # turn each tweet into a Tweet object
    tweets_array.each do |tweet|
      tweet_hash = {
        twitter_id: tweet.id,
        text: tweet.text,
        uri: tweet.uri,
        twitter_user_id: twitter_user.id
      }
      Tweet.create(tweet_hash)
    end
  end
end
