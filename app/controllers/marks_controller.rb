class MarksController < ApplicationController
  before_action :search, only: [:vimeo_subscribe]
  before_action :require_spy, only: [:index, :search, :show]

  def twitter
    Seemore::Application.config.twitter
  end

  def index
    @marks = current_spy.marks
  end

  def search
    if params[:username].present?
      search_params = { username: params[:username], provider: params[:provider], id: params[:id] }
      @search_term = search_params[:username]
      if search_params[:provider] == "vimeo"
        @mark = Mark.vimeo_lookup(@search_term)
      elsif search_params[:provider] == "twitter"
        @marks = twitter_lookup(@search_term)
        if @marks.empty?
          @flash = true
        end
      end
    end
  end

  def twitter_lookup(search_term)
    marks = []
    users = twitter.user_search(search_term)
    users.each do |user|
      mark = Mark.new(
        username: user.screen_name,
        name: user.name,
        bio: user.description,
        link: user.url,
        image_url: user.profile_image_url(size = :original),
        uid: user.id,
        location: user.location,
        provider: "twitter"
      )
      marks.push(mark)
    end
    return marks
  end

  def single_mark_twitter_lookup(search_term)
    user = twitter.user(search_term)
    mark = Mark.new(
      username: user.screen_name,
      name: user.name,
      bio: user.description,
      link: user.url,
      image_url: user.profile_image_url(size = :original),
      uid: user.id,
      location: user.location,
      provider: "twitter"
    )
    return mark
  end

  def vimeo_subscribe
    @mark = Mark.vimeo_lookup(params[:name])

    if Mark.find_by(username: @mark.username).nil?
      @mark = Mark.vimeo_lookup(params[:name])
    else
      @mark = Mark.find_by(username: @mark.username)
    end

    @mark.save
    current_spy.marks << @mark

    Mark.video_lookup(@mark.username)

    redirect_to marks_path
  end

  def twitter_subscribe
    @mark = single_mark_twitter_lookup(params[:name])

    if Mark.find_by(username: @mark.username).nil?
      @mark = single_mark_twitter_lookup(params[:name])
    else
      @mark = Mark.find_by(username: @mark.username)
    end

    @mark.save
    current_spy.marks << @mark

    @tweets = twitter.user_timeline[0..9]
    @tweets.each do |tweet|
      Medium.create(
        mark_id: @mark.id, 
        date_posted: tweet.created_at, 
        link: tweet.source, 
        text: tweet.text, 
        medium_type: "twitter"
        )
    end

    redirect_to marks_path
  end

  def destroy
    @mark = current_spy.marks.find(params[:id])
    @mark.save
    @mark.destroy
    redirect_to marks_path
  end
end
