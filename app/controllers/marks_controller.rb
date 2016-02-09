class MarksController < ApplicationController
  before_action :results, only: [:vimeo_subscribe]
  before_action :require_spy, only: [:index, :results, :show]

  def twitter
    Seemore::Application.config.twitter
  end

  def index
    @marks = current_spy.marks
  end

  def results
    if params[:username].present?
      search_params = { username: params[:username], id: params[:id] }
      @search_term = search_params[:username]
      @vimeo_marks = Mark.vimeo_lookup(@search_term)
      @twitter_marks = twitter_lookup(@search_term)
    end
  end

  def twitter_lookup(search_term)
    marks = []
    users = twitter.user_search(search_term)
    users.each do |user|
      mark = Mark.create(
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
    @mark = Mark.single_mark_vimeo_lookup(params[:name])

    if Mark.where(uid: @mark.uid).where(provider: "vimeo").first.nil?
      @mark = Mark.single_mark_vimeo_lookup(params[:name])
      @mark.save
      current_spy.marks << @mark
    else
      if !current_spy.marks.where(uid: @mark.uid).where(provider: @mark.provider).first.nil?
        flash[:error] = "You already follow that Mark."
        return redirect_to marks_path
      else
        @mark = Mark.where(uid: @mark.uid).where(provider: "vimeo").first
        current_spy.marks << @mark
      end
    end

    @mark.refresh
    redirect_to marks_path
  end

  def twitter_subscribe
    @mark = single_mark_twitter_lookup(params[:name])

    if Mark.where(uid: @mark.uid).where(provider: "twitter").first.nil?
      @mark = single_mark_twitter_lookup(params[:name])
      @mark.save
      current_spy.marks << @mark
    else
      if !current_spy.marks.where(uid: @mark.uid).where(provider: @mark.provider).first.nil?
        flash[:error] = "You already follow that Mark."
        return redirect_to marks_path
      else
        @mark = Mark.where(uid: @mark.uid).where(provider: "twitter").first
        current_spy.marks << @mark
      end
    end
    @mark.refresh
    redirect_to marks_path
  end

  def destroy
    @mark = current_spy.marks.find(params[:id])
    @mark.save
    current_spy.marks.delete(@mark)
    redirect_to marks_path
  end
end
