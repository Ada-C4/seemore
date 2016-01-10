class SearchController < ApplicationController
  include SearchHelper
  
  def index
    #add logic for if there are no results returned
    search_term = params[:search_term]
    if twitter_result?
      @results = $client.user_search(search_term)
    elsif vimeo_result?
      @results = search_vimeo(search_term)["data"]
    end

  end

  private

  def search_vimeo(search_term)
    HTTParty.get(vim_base_uri + "/users?page=1&per_page=25&query=#{search_term}&fields=uri,name,bio,pictures",
    headers: {"Authorization" => "bearer #{vimeo_access_token}", 'Accept' => 'application/json' }, format: :json).parsed_response
  end

end
