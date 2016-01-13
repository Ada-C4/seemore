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
              # binding.pry
            end
          end

        elsif mark.provider == "vimeo"
          Medium.video_lookup(mark.username)
        end
      end
      if params[:filter] == "vimeo"
        @media = current_spy.media.where(medium_type: "vimeo").sort_by { |m| DateTime.parse(m.date_posted) }.reverse.take(20)
      elsif params[:filter] == "twitter"
        @media = current_spy.media.where(medium_type: "twitter").sort_by { |m| DateTime.parse(m.date_posted) }.reverse.take(20)
      else
        @media = current_spy.media.sort_by { |m| DateTime.parse(m.date_posted) }.reverse.take(20)
      end
    end
  end
end
