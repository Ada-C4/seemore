Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer,
    :fields => [:username],
    :uid_field => :username

  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  provider :vimeo, ENV['VIMEO_KEY'], ENV['VIMEO_SECRET'], authorize_params: {permission: "write"}
end
