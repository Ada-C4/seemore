class SearchController < ApplicationController
  include SearchHelper
  include VimeoWrapper

  def index
    #add logic for if there are no results returned
    search_term = params[:search_term]
    if twitter_result?
      @results = $client.user_search(search_term)
    elsif vimeo_result?
      @results = search_vimeo(search_term)["data"]
    end
  end
end
