Instagram.configure do |config|
  config.client_id    = ENV["INSTAGRAM_CONSUMER_KEY"]
  config.client_secret = ENV["INSTAGRAM_CONSUMER_SECRET"]
  config.access_token = ENV["INSTAGRAM_ACCESS_TOKEN"]
end
