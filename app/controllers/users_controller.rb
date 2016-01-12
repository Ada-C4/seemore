class UsersController < ApplicationController
  before_action :current_user

  def subscriptions
    @twitter_subscriptions = @current_user.twitter_users
    @vimeo_subscriptions = @current_user.vimeo_users
  end
end
