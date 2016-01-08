class CreatorsController < ApplicationController

  def create
    @creator = Creator.new(
    name: params["name"],
    provider: params["provider"],
    profile_pic: params["profile_pic"],
    description: params["bio"],
    )
    @creator.save
    @creator.users << @current_user
    redirect_to creators_path
  end




end
