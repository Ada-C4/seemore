require 'twitter'

class TwitterClient
  def self.connect
    twitter_client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_CLIENT_ID"]
      config.consumer_secret     = ENV["TWITTER_CLIENT_SECRET"]
      #config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
      #config.access_token_secret = ENV["TWITTER_ACCESS_SECRET"]
    end
  end
end

Seemore::Application.config.twitter = TwitterClient.connect
