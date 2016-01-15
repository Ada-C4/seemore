class UsersController < ApplicationController

  def show
    videos = @current_user.videos.to_ary.sort_by{|video| video.posted_at}.reverse![0..8]
    tweets = @current_user.tweets.to_ary.sort_by{|tweet| tweet.posted_at}.reverse![0..8]
    @media = [tweets, videos].flatten.sort_by{|media| media.posted_at}.reverse!
  end

end
