require 'pry'
class MediaController < ApplicationController
  def twitter
    Seemore::Application.config.twitter
  end

  def index
    if !current_spy.nil?
      @marks = current_spy.marks

      @marks.each do |mark|
        if mark.provider == "twitter"
          @tweets = twitter.user_timeline(mark.username, count: 20)
          @tweets.each do |tweet|
            # binding.pry
            if Medium.find_by(uid: tweet.id).nil?
              Medium.create(
                mark_id: mark.id,
                date_posted: tweet.created_at,
                link: tweet.source,
                text: tweet.text,
                medium_type: "twitter",
                uid: tweet.id
                )
            end
          end

        elsif mark.provider == "vimeo"
          Medium.video_lookup(mark.username)
        end
      end
      if params[:filter] == "vimeo"
        @media = Medium.vimeo_filter(current_spy.media)
      elsif params[:filter] == "twitter"
        @media = Medium.twitter_filter(current_spy.media)
      else
        @media = Medium.no_filter(current_spy.media)
      end
    end
  end
end
