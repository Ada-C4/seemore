class CreatorsController < ApplicationController
  include HTTParty
  LIMIT_PER_PAGE = 10

  #use private methods to determine which api to search
  def search
    query = params[:query].gsub(/\W/, "")
    if query == ""
      flash["error"] = "Invalid search term."
      redirect_to root_path
    elsif params[:provider] == "vimeo"
      @creators = vimeo_search(query).paginate(:page => params[:page], :per_page => 10)
      render :search
    else
      @creators = twitter_search(query).paginate(:page => params[:page], :per_page => 10)
      render :search
    end
  end

  private
    def vimeo_search(query)
     response = HTTParty.get("https://api.vimeo.com/users?per_page=#{LIMIT_PER_PAGE}&query=#{query}", headers: {"Authorization" => "bearer #{ENV['VIMEO_ACCESS_TOKEN']}"})
     json_res = convert_to_json(response)
     vimeo_users = json_res["data"]
     Creator.make_vimeo_creators(vimeo_users)
    end

    def convert_to_json(httparty_response)
      return JSON.parse(httparty_response.parsed_response)
    end

    #method to configure twitter
    def twit
      Seemore::Application.config.twitter
    end

    def twitter_search(query)
      #searches for users
      twitter_users = twit.user_search(query)
      Creator.make_twitter_creators(twitter_users)
    end
end
