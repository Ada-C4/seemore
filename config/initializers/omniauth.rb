Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer
    # :fields => [:username],
    # :uid_field => :last_name

  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
end
