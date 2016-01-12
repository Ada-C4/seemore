require 'vimeo'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :signed_in?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def signed_in?
    !!current_user
  end

  def correct_user
    user = User.find(params[:id])
    unless user == current_user
      flash[:error] = "You do not have permission to access that page."
      redirect_to(root_path)
    end
  end

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.nil? ? nil : user.id
  end

  def require_login
    unless current_user
      flash[:error] = "Please log in to view this section."
      redirect_to root_path
    end
  end

  def update_feed
    query_string = ""
    response = []

    current_user.handles.each do |handle|
      query_string += "from:#{handle.name} OR " if handle.provider == "twitter"
      response += Vimeo::Video.get_user_videos(handle.uri) if handle.provider == "vimeo"
    end

    response += $twitter.search(query_string, result_type: "recent").take(2)

    media = Medium.all
    tracked = Array.new

    unless media.empty?
      media.each do |medium|
        tracked << medium.uri
      end
    end

    current_user.handles.each do |handle|
      response.each do |medium|
        unless tracked.include?(medium.uri.to_s)
          Medium.create(uri: medium.uri, embed: medium.embed, posted_at: medium.posted_at, handle_id: handle.id) if medium.class == Vimeo::Video
          if medium.class == Twitter::Tweet
            new_tweet = Medium.create_tweet_medium(medium)
            new_tweet.update(handle_id: handle.id)
          end
        end
      end
    end
  end
end
