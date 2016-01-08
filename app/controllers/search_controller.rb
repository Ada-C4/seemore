class SearchController < ApplicationController
  def index
    # will need to add conditional logic for Twitter or Instagram
    if params[:provider] == "1"
      search_term = params[:search_term]
      @results = $client.user_search(search_term)
    else
      ## fill this in later!
      @results = []
    end
  end
end
