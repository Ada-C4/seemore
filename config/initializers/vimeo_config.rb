# $client = Vimeo::REST::Client.new do |config|
#   config.client_id    = ENV["VIMEO_CLIENT_ID"]
#   config.client_secret = ENV["VIMEO_CLIENT_SECRETS"]
#   config.access_token = ENV["VIMEO_ACCESS_TOKEN"]
# end

# class VimeoUserFetcher
#   include HTTParty
#   base_uri 'https://api.vimeo.com'
#
#   # attr_reader:
#
#   def initialize(u, p)
#     @auth = {username: u, password: p}
#   end
#
#   def search_user(username)
#     results = HTTParty.get("/users?page=1&per_page=25&query=#{search_term}&fields=uri,name,bio,pictures",
#     headers: {"Authorization" => "bearer #{access_token}", 'Accept' => 'application/json' }, format: :json).parsed_response
#    if results["total"] == 0
#      flash.now[:error] = "We couldn't find that user."
#    else
#      @results = results["data"]
#   end
#
#   def user_info
#
#   end
#
#   private
#
#   def access_token
#     ENV["VIMEO_ACCESS_TOKEN"]
#   end
# end
