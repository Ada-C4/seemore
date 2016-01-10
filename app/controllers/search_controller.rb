class SearchController < ApplicationController
  def index
    #add logic for if there are no results returned
    if params[:provider] == "1" #twitter
      search_term = params[:search_term]
      @results = $client.user_search(search_term)
    else #vimeo
      @results = search_vimeo(search_term)
    end

  end

  private

  def search_vimeo(search_term)
    HTTParty.get("https://api.vimeo.com/users?page=1&per_page=25&query=#{search_term}&fields=uri,name,bio,pictures",
    headers: {"Authorization" => "bearer #{vimeo_access_token}", 'Accept' => 'application/json' }, format: :json).parsed_response
  end

  def vimeo_access_token
    ENV["VIMEO_ACCESS_TOKEN"]
  end
end
