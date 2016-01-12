class CreatorsController < ApplicationController

  def index
    if !@current_user.creators.nil?
      @creators = @current_user.creators
    else
      flash.now[:notice] = "Try following some people first!"
    end
  end

  def create
    # find or create a Creator
    @creator = Creator.find_by(name: params["uri"]) #use id and provider
    if !@creator.nil?
      if !@current_user.creators.include?(@creator)
        @creator.users << @current_user
        flash[:notice] = "You're now following #{@creator.name}."
      elsif @current_user.creators.include?(@creator)
        flash[:notice] = "You're already following #{@creator.name}"
      end
    else
      if !params["profile_pic"].nil?
        pic = params["profile_pic"]["sizes"][2]["link"]
      else
        pic = "twitter_default_image.png"
      end
        Creator.transaction do
          @creator = Creator.new(
            uri: params["uri"],
            name: params["name"],
            provider: params["provider"],
            profile_pic: pic,
            uid: params["uid"])
          if @creator.provider == "vimeo"
            @creator.profile_pic = params["profile_pic"]["sizes"][2]["link"]
          else
            @creator.profile_pic = params["profile_pic"]
          end
        @creator.save
        @creator.users << @current_user
        @creator.add_videos
        flash[:notice] = "You're now following #{@creator.name}."
      end
      redirect_to :back
    end
  end
end
