class CreatorsController < ApplicationController

  def index
    if !@current_user.creators.nil?
      @creators = @current_user.creators
    else
      flash.now[:notice] = "Try following some people first!"
    end
  end

  def follow
    creator = Creator.find_or_create(params)
    if creator.nil?
      flash[:error] = "Failed to follow"
    else
      if !@current_user.creators.include?(creator)
        creator.users << @current_user
        flash[:notice] = "You're now following #{creator.name}."
      elsif @current_user.creators.include?(creator)
        flash[:notice] = "You're already following #{creator.name}"
      end
    end
      redirect_to :back
  end

  def unfollow
    creator = Creator.find_or_create(params)
    @current_user.creators.delete(creator)
    redirect_to :back
  end
end

      # if !params["profile_pic"].nil?
      #   pic = params["profile_pic"]["sizes"][2]["link"]
      # else
      #   pic = "twitter_default_image.png"
      # end
      #   Creator.transaction do
      #     @creator = Creator.new(
      #       uri: params["uri"],
      #       name: params["name"],
      #       provider: params["provider"],
      #       profile_pic: pic,
      #       uid: params["uid"])
      #     if @creator.provider == "vimeo"
      #       @creator.profile_pic = params["profile_pic"]["sizes"][2]["link"]
      #     else
      #       @creator.profile_pic = params["profile_pic"]
      #     end
      #   @creator.save
      #   @creator.users << @current_user
      #   videos_array = @creator.get_videos
      #   Video.create_videos_for_creator_from_hashes(videos_array, @creator)
      # end
      # flash[:notice] = "You're now following #{@creator.name}."
      # redirect_to :back
