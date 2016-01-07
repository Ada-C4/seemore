class MarksController < ApplicationController

  def search 
    if params[:username].present?
      search_params = { username: params[:username], provider: params[:provider] }

      @search_term = search_params[:username]
      @mark = Mark.lookup(@search_term)
    end

  end
end
