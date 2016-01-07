class MarksController < ApplicationController

  def create_search 
    if params[:search_term].present?
      search_params = { search_term: params[:search_term], provider: params[:provider] }
      redirect_to results_path(search_params)
    else
      redirect_to search_path(params[:provider])
    end
  end

  def results
  end
end
