class MarksController < ApplicationController
  before_action :search, only: [:vimeo_subscribe]

  def index
    @marks = Mark.all
  end

  def search 
    if params[:username].present?
      search_params = { username: params[:username], provider: params[:provider], id: params[:id] }
      # raise
      @search_term = search_params[:username]
      if search_params[:provider] == "vimeo"
        @mark = Mark.vimeo_lookup(@search_term)
      end
    end
  end

  def vimeo_subscribe
    redirect_to marks_path
  end
end
