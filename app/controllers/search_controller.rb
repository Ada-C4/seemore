class SearchController < ApplicationController
  def index
      if params[:provider] == "1"
        search_term = params[:search_term]
        @results = $client.user_search(search_term)
      else
        @results = 
      end
    end
  end
end
