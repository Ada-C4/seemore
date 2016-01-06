# config/initializers/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, YOUR_CLIENT_ID, YOUR_CLIENT_SECRET
end
