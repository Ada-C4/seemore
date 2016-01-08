Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer,
    :fields => [:name, :uid] if Rails.env.development?

  provider :twitter, ENV["TWITTER_CLIENT_ID"], ENV["TWITTER_CLIENT_SECRET"], scope: "user:email"
#
#
#   #provider :vimeo
end
