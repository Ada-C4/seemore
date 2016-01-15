require 'will_paginate/array'

class MediaController < ApplicationController

  def twitter
    Seemore::Application.config.twitter
  end

  def index
    if !current_spy.nil?
      @marks = current_spy.marks
      @marks.each do |mark|
        if mark.provider == "twitter"
          @tweets = twitter.user_timeline(mark.username, count: 50)
          @tweets.each do |tweet|
            if Medium.find_by(uid: tweet.id).nil?
              Medium.create(
                mark_id: mark.id,
                date_posted: tweet.created_at,
                link: tweet.source,
                text: tweet.text,
                medium_type: "twitter",
                uid: tweet.id,
                retweeted_from: tweet.retweeted_status.user.screen_name,
                retweeted_from_link: tweet.retweeted_status.user.url
                )
            end
          end

        elsif mark.provider == "vimeo"
          Medium.video_lookup(mark.username)
        end
      end
      if params[:filter] == "vimeo"
        @media = Medium.vimeo_filter(current_spy.media).paginate(:page => params[:page], :per_page => 15)
      elsif params[:filter] == "twitter"
        @media = Medium.twitter_filter(current_spy.media).paginate(:page => params[:page], :per_page => 15)
      else
        @media = Medium.no_filter(current_spy.media).paginate(:page => params[:page], :per_page => 15)
      end
    end
  end

  def refresh
    @marks = current_spy.marks
    @marks.each do |mark|
      mark.refresh
    end
    redirect_to root_path
  end
end
