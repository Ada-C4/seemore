class SearchController < ApplicationController
  def index
    if params[:]
    search_term = params[:search_term]
    @results = $client.user_search(search_term)

  end
end
