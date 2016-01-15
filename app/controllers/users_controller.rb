
class UsersController < ApplicationController
  skip_before_action :require_login,only: [:feed]

  def show
    @creators = current_user.creators
  end

  def feed
    #user not logged in
   if session[:user_id].nil?
     redirect_to login_path
   else
     # check for new content from all the creators
     current_user.creators.each do |creator|
      # update creator from api if last updated more than 6 hours ago
      if creator.last_updated.nil? || creator.last_updated < 6.hours.ago
        creator.get_content
      end
     end
     @contents = current_user.content.flatten
     @contents = @contents.flatten.sort_by! { |content| content[:create_time] }.reverse
     @contents = @contents.paginate(:page => params[:page], :per_page => 10)
     render "feed"
   end
  end

  def delete; end

  def create; end

  # adds a creator to the user's list
  def update
    creator, following = current_user.following(params["provider"], params["p_id"])
    if !following
      if creator.nil?
      # if the creator does not exist, create creator
        creator = Creator.create(creator_hash(params))
        creator.get_content
      end
      current_user.creators << creator
      flash[:notice] = "#{creator.username} has been added to your feed!"
    end
    redirect_to root_path
  end

  #remove a creator from a user's follow list
  def delete_creator
    # find creator from params
    creator = Creator.find_by(provider: params["provider"], p_id: params["p_id"])
    # remove creator from user's list
    current_user.creators.delete(creator)
    # if the creator is no longer followed, delete it
    creator.delete if creator.users.nil?
    redirect_to current_user
  end

  private
  def creator_hash(params)
    creator_hash = {}
    creator_hash[:p_id] = params["p_id"]
    creator_hash[:username] = params["username"]
    creator_hash[:avatar_url] = params["avatar_url"]
    creator_hash[:provider] = params["provider"]
    return creator_hash
  end
end
