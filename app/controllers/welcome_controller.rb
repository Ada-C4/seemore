class WelcomeController < ApplicationController
  before_action :current_user
  include VimeoWrapper

  def index
    if @current_user.nil?
      redirect_to login_path
    else
      @feed = make_feed(@current_user)
    end
  end

def make_feed(current_user)
   feed = []
   current_user.twitter_users.each do |user|
     user.tweets.each do |tweet|
         feed.push(tweet)
     end
   end
   current_user.vimeo_users.each do |user|
     user.videos.each do |video|
       feed.push(video)
     end
   end
   sorted = feed.sort_by(&:provider_created_at).reverse!
   trimmed = sorted[0...74]
   return trimmed
 end
end
