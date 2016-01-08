class TwitterUsersController < ApplicationController
  def create
  screen_name = strong_params[:screen_name]
    # find user using Twitter API
    new_twitter_user = $client.user(screen_name)
    # create hash using info from Twitter API
    twitter_user_hash = {
      twitter_id: new_twitter_user.id,
      screen_name: new_twitter_user.screen_name,
      name: new_twitter_user.name,
      description: new_twitter_user.description,
      location: new_twitter_user.location,
      uri: new_twitter_user.uri,
      profile_image_uri: new_twitter_user.profile_image_uri
    }
    @twitter_user = TwitterUser.create(twitter_user_hash)
    redirect_to :root
  end

  private

  def strong_params
    params.require(:twitter_user).permit(:screen_name)
  end
end
