class Handle < ActiveRecord::Base
  has_many :media
  has_and_belongs_to_many :users
  validates :name, :uri, :provider, presence: true

  def self.search(query)
    @results = $twitter.user_search(query)
  end

  def self.create_twitter_handle(twitter_user_instance)
    # twitter_user_instance will come from twitter gem (ex: calling $twitter.user("houglande"),
    # which returns an instance of their twitter::user class)

    handle = Handle.new
    handle.name = twitter_user_instance.name
    handle.uri = twitter_user_instance.uri
    handle.profile_image_uri = twitter_user_instance.profile_image_uri
    handle.provider = "twitter"
    handle.save
  end

  def self.create_vimeo_handle(uri)
    user = Vimeo::User.find_by_uri(uri)
    Handle.create(
      name: user.name,
      uri: user.uri,
      provider: "vimeo"
    )
  end
end
