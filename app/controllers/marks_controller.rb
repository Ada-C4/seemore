class MarksController < ApplicationController
  before_action :search, only: [:vimeo_subscribe]

  def twitter
    Seemore::Application.config.twitter
  end

  def index
    @marks = Mark.all
  end

  def search
    if params[:username].present?
      search_params = { username: params[:username], provider: params[:provider], id: params[:id] }
      @search_term = search_params[:username]
      if search_params[:provider] == "vimeo"
        @mark = Mark.vimeo_lookup(@search_term)
      elsif search_params[:provider] == "twitter"
        @mark = Mark.twitter_lookup(@search_term)
      end
    end
  end

  def vimeo_subscribe
    @mark = Mark.vimeo_lookup(params[:name])
    @mark.save
    redirect_to marks_path
  end
end
