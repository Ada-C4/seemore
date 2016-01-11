require 'json'
class SearchesController < ApplicationController


  def search
    if params[:provider] == "vimeo"
      search_term = params[:search]
      vimeo_access_token = ENV["VIMEO_ACCESS_TOKEN"]
      results = HTTParty.get("https://api.vimeo.com/users?page=1&per_page=25&query=#{search_term}&fields=name,bio,pictures",
       headers: {"Authorization" => "bearer #{vimeo_access_token}", 'Accept' => 'application/json' }, format: :json).parsed_response
       if results["total"] == 0
         flash.now[:error] = "No results matched your search."
       else
         @results = results["data"]
         @provider = "vimeo"
       end
    elsif params[:provider] == "twitter"
      search_term = params[:search]
      @results = $twitter.user_search("#{search_term}").take(25)
      if @results.length == 0
        flash.now[:error] = "No results matched your search."
      else
        @provider = "twitter"
      end
    end
  end
end
