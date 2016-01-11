class VimeoUsersController < ApplicationController
  before_action :current_user
  include VimeoHelper

  def subscribe
    @vim_uri = params[:uri]
    if !vimeo_user_exists?
      # if vimeo_user doesn't exist, create vimeo_user and their videos
      create_vimeo_user(@vim_uri)
      create_videos(@vim_uri)
    end
    @vimeo_user = VimeoUser.find_by(uri: @vim_uri)
    #subscribe to vimeo_user
    @current_user.vimeo_users << @vimeo_user
    redirect_to :root
  end

  private

  def vimeo_user_exists?
    if VimeoUser.find_by(uri: @vim_uri)
      return true
    else
      return false
    end
  end

  def create_vimeo_user(vimeo_user_uri)
    new_vimeo_user = get_vimeo_user(vimeo_user_uri)
    # create hash using info from Vimeo API

    vimeo_user_hash = {
      uri: new_vimeo_user["uri"],
      name: new_vimeo_user["name"],
      description: new_vimeo_user["bio"],
      location: new_vimeo_user["location"],
      profile_images_uri: new_vimeo_user["metadata"]["connections"]["pictures"]["uri"],
      videos_uri: new_vimeo_user["metadata"]["connections"]["videos"]["uri"]
    }
    @vimeo_user = VimeoUser.create(vimeo_user_hash)
  end

  def create_videos(vimeo_user_uri)
    # grab videos from Vimeo API - allowing 5 per page.
    video_call = get_user_videos(vimeo_user_uri)
    videos = video_call["data"]
    # turn each video into a Video object
    videos.each do |video|
      video_hash = {
        uri: video["uri"],
        title: video["title"],
        vimeo_video_id: video["uri"].match(/[0-9]+$/)[0]
      }
      Video.create!(video_hash)
    raise
    end
  end
end
