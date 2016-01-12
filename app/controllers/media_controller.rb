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
            # raise
          @tweets.each do |tweet|
            Medium.create(
              mark_id: mark.id, 
              date_posted: tweet.created_at, 
              link: tweet.source, 
              text: tweet.text, 
              medium_type: "twitter"
              )
            # binding.pry
          end
        elsif mark.provider == "vimeo"
          Mark.video_lookup(mark.username)
        end
        # binding.pry
      end

      @media = current_spy.media.sort_by { |m| DateTime.parse(m.date_posted) }.reverse.take(20)
      # raise
      # binding.pry
    end
  end
end
