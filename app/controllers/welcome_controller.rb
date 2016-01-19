require 'will_paginate/array'

class WelcomeController < ApplicationController
  def index
    if current_user
      media = Medium.sorted_media(current_user)
      @media = media.paginate(:page => params[:page], :per_page => 15)
    end
  end

  def filter
    filter = params[:filter]
    sorted_media = Medium.sorted_media(current_user)
    media = Medium.filter_media(filter, sorted_media)
    if media.length < 1
      redirect_to root_path
    else
      @media = media.paginate(:page => params[:page], :per_page => 15)
      render :index
    end
  end

end
