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
    tracked = Medium.pluck(:uri)

    current_user.handles.each do |handle|
      query_string += "from:#{handle.name} OR " if handle.provider == "twitter"

      if handle.provider == "vimeo"
        vimeo_responses = Vimeo::Video.get_user_videos(handle.uri) || []
        vimeo_responses.each do |response|
          unless tracked.include?(response.uri.to_s)
            Medium.create(uri: response.uri, embed: response.embed, posted_at: response.posted_at, handle: handle)
          end
        end
      end
    end

    unless query_string.empty?
      twitter_response = $twitter.search(query_string, result_type: "recent").take(100)
      twitter_response.each do |response|
        unless tracked.include?(response.uri.to_s)
          handle = Handle.find_by(name: response.user.screen_name)
          new_tweet = Medium.create_tweet_medium(response)
          new_tweet.update(handle: handle)
        end
      end
    end

  end
end
