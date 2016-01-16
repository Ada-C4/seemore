# config/initializers/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
  if !Rails.env.production?
    provider :developer,
      :fields => [:uid, :name, :provider, :image],
      :uid_field => :uid
  else
    provider :twitter, ENV["TWITTER_CONSUMER_KEY"], ENV["TWITTER_CONSUMER_SECRET"]
    provider :vimeo, ENV["VIMEO_CLIENT_ID"], ENV["VIMEO_CLIENT_SECRETS"]
  end
end
