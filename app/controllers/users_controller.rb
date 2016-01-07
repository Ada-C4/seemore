class UsersController < ApplicationController

  def twitter
    Seemore::Application.config.twitter
  end

  def vimeo
    Seemore::Application.config.vimeo
  end

  def show

    @sample_stories = twitter.user_timeline("Schwarzenegger")
  #  @vimeo_stories = vimeo.user.info("Schwarzenegger")
  end

  def twitter_search
    search_term = params[:search]
    @search_results = twitter.search(search_term, result_type: "recent").take(20)
  end
end
