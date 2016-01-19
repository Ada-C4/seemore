require 'vimeo'

class HandlesController < ApplicationController
  before_action :require_login

  def subscribe
    # params coming from the search result page
    provider = params["provider"]
    handle_uri = params["handle_uri"]
    # see if we have this Handle already in our db
    handle = Handle.find_by(uri: handle_uri)

    if handle.nil? # not in our db
      # conditional based on provider
      if provider == "twitter"
        handle_username = params["handle_username"]
        handle = Handle.create_twitter_handle(handle_username)
        tweets = $twitter.user_timeline(handle_username).take(5)
        tweets.each do |tweet|
          medium = Medium.create_tweet_medium(tweet)
          medium.handle_id = handle.id
          medium.save
        end
      elsif provider == "vimeo"
        handle = Handle.create_vimeo_handle(handle_uri)
        videos = Vimeo::Video.get_user_videos(handle.uri)
        videos.each do |video|
          Medium.create(handle_id: handle.id, uri: video.uri, embed: video.embed, posted_at: video.posted_at)
        end
      end
    end
    if current_user.handles.include?(handle)
      flash[:error] = "Already subscribed!"
      redirect_to :back
    else
      current_user.handles << handle
      flash[:success] = "Subscription added!"
      redirect_to :back
    end
  end

  def unsubscribe
    handle_uri = params["handle_uri"]
    handle = Handle.find_by_uri(handle_uri)
    current_user.handles.delete(handle)
    current_user.save
    if handle.users.empty?
      Handle.destroy(handle.id)
    end
    flash[:success] = "Unsubscribed!"
    redirect_to :back
  end

  def search
    name = params[:query]

    @vimeo_search_results = Vimeo::User.find_by_name(name)
    @vimeo_search_results.each do |sr|
      handle = Handle.find_by_uri(sr.uri)
      if current_user.handles.include?(handle)

        sr.subscribed = true

      end
    end
    @twitter_search_results = $twitter.user_search(name)
  end
end
