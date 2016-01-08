Vimeo.configure do |config|
  config.client_id    = ENV["VIMEO_CLIENT_ID"]
  config.client_secret = ENV["VIMEO_CLIENT_SECRETS"]
  config.access_token = ENV["VIMEO_ACCESS_TOKEN"]
end
