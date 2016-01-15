Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer,
    :fields => [:name, :uid],
    :uid_field => :uid if Rails.env.development?
  provider :vimeo, ENV['VIMEO_KEY'], ENV['VIMEO_SECRET']
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
end
