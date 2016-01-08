# config/initializers/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
  if !Rails.env.production?
    provider :developer,
      :fields => [:uid, :name, :provider, :image],
      :uid_field => :uid
  else
    provider :twitter, ENV["TWITTER_CONSUMER_KEY"], ENV["TWITTER_CONSUMER_SECRET"]
    provider :instagram, ENV["INSTAGRAM_CONSUMER_KEY"], ENV["INSTAGRAM_CONSUMER_SECRET"], ENV["INSTAGRAM_ACCESS_TOKEN"]
  end
end
