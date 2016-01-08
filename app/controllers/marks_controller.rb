class MarksController < ApplicationController
  before_action :search, only: [:vimeo_subscribe]

  def twitter
    Seemore::Application.config.twitter
  end

  def index
    @marks = current_spy.marks
    raise
  end

  def search
    if params[:username].present?
      search_params = { username: params[:username], provider: params[:provider], id: params[:id] }
      @search_term = search_params[:username]
      if search_params[:provider] == "vimeo"
        @mark = Mark.vimeo_lookup(@search_term)
      elsif search_params[:provider] == "twitter"
        @mark = twitter_lookup(@search_term)
      end
    end
  end

  def show 
  end

  def twitter_lookup(search_term)
    user = twitter.user(search_term)
    mark = Mark.new(
      username: user.screen_name,
      name: user.name,
      bio: user.description,
      link: user.url,
      image_url: user.profile_image_url,
      uid: user.id,
      location: user.location,
      provider: "twitter"
    )
    return mark
  end

  def vimeo_subscribe
    @mark = Mark.vimeo_lookup(params[:name])
    @mark.save
    current_spy.marks << @mark
    redirect_to marks_path
  end

  def twitter_subscribe
    @mark = twitter_lookup(params[:name])
    @mark.save
    redirect_to marks_path
  end
end
