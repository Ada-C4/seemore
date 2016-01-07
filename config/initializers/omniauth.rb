# config/initializers/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
  if !Rails.env.production?
    provider :developer,
      :fields => [:uid, :name, :provider, :image]
  else
    provider :twitter, ENV["TWITTER_CONSUMER_KEY"], ENV["TWITTER_CONSUMER_SECRET"]
  end
end
