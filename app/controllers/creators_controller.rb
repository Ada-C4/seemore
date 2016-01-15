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
