class Medium < ActiveRecord::Base
  belongs_to :handle
  validates :uri, :posted_at, presence: true

  def self.create_tweet_medium(tweet_instance)
    medium = Medium.new
    medium.uri = tweet_instance.uri
    medium.posted_at = tweet_instance.created_at
    medium.save
    medium.set_embed(tweet_instance)
    return medium
  end

  def self.sorted_media(current_user)
    current_user.media.order(posted_at: :desc)
  end

  def self.filter_media(filter, media)
    media.find_all do |medium|
      medium.handle.provider == filter
    end
  end

  def set_embed(tweet_instance)
    response = HTTParty.get("https://api.twitter.com/1/statuses/oembed.json?url=https://twitter.com/Interior/status/#{tweet_instance.id}")
    unescaped = response["html"].delete('\"')
    self.embed = unescaped.delete("\n")
    self.save
  end
end
