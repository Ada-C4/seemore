class SearchController < ApplicationController
  def index
    # will need to add conditional logic for Twitter or Instagram
    search_term = params[:search_term]
    @results = $client.user_search(search_term)

    
  end
end
