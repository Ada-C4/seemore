Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV["TWITTER_CLIENT_ID"], ENV["TWITTER_CLIENT_SECRET"]
  provider :vimeo, ENV["VIMEO_CLIENT_ID"], ENV["VIMEO_CLIENT_SECRET"]

  if Rails.env.development?
    provider :developer
  end
end
