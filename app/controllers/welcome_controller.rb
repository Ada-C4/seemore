class WelcomeController < ApplicationController
  before_action :current_user
  include VimeoWrapper

  def index
    if @current_user.nil?
      redirect_to login_path
    else
      @twitter_user = TwitterUser.new()
      @vid = get_video(145516416)
      @feed = feed
    end
  end
end

def feed
   @feed = []
   @current_user.twitter_users.each do |user|
     user.tweets.each do |tweet|
         @feed.push(tweet)
     end
   end
   @current_user.vimeo_users.each do |user|
     user.videos.each do |video|
       @feed.push(video)
     end
   end
   return @feed
 end
