class HandlesController < ApplicationController
  def show
    @handle = Handle.find(params[:id])
  end

  def add

  end

  def remove

  end

  def search
    Handle.search(query)
  end
end
