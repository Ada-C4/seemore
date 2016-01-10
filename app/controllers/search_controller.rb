class SearchController < ApplicationController
  def index
    if params[:provider] == "1" #twitter
      search_term = params[:search_term]
      @results = $client.user_search(search_term)
    else #vimeo
      @results = []
    end
  end
end
