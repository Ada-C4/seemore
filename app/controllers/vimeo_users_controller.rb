class VimeoUsersController < ApplicationController
  # def create
  #   screen_name = strong_params[:screen_name]
  #   # find user using Vimeo API
  #   new_vimeo_user = $client.user(screen_name)
  #   # create hash using info from Vimeo API
  #   vimeo_user_hash = {
  #     vimeo_id: new_vimeo_user.id,
  #     screen_name: new_vimeo_user.ßscreen_name,
  #     name: new_vimeo_user.name,
  #     description: new_vimeo_user.description,
  #     location: new_vimeo_user.location,
  #     uri: new_vimeo_user.uri,
  #     profile_image_uri: new_vimeo_user.profile_image_uri
  #   }
  #   @vimeo_user = VimeoUser.create(vimeo_user_hash)
  #   redirect_to :root
  # end


  private

  def strong_params
    params.require(:vimeo_user)
  end
end
