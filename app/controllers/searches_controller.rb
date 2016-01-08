class SearchesController < ApplicationController

  def search
    search_term = params[:search]
    env = ENV["VIMEO_ACCESS_TOKEN"]
    @results = HTTParty.get("https://api.vimeo.com/users?page=1&per_page=25&query=#{search_term}", headers: {"Authorization" => "bearer #{env}"})
  end
  
end
