class MarksController < ApplicationController
  before_action :search, only: [:vimeo_subscribe]

  def index
    @marks = current_spy.marks
    # raise
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

  def show 

  end

  def vimeo_subscribe
    @mark = Mark.vimeo_lookup(params[:name])
    @mark.save
    current_spy.marks << @mark
    redirect_to marks_path
  end
end
