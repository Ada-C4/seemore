class UsersController < ApplicationController

  def twitter
    Seemore::Application.config.twitter
  end

  def vimeo
    Seemore::Application.config.vimeo
  end

  def show
    @sample_stories = twitter.user_timeline("Schwarzenegger")
    @vimeo_stories = Vimeo::Simple::User.videos("15397797")

  end

  def twitter_search
    search_term = params[:search]
    @search_results = twitter.user_search(search_term).take(20)
  end

  def vimeo_search
    search_term = params[:search]
    @vimeo_results = Vimeo::Simple::User.info(search_term)
  end
end
