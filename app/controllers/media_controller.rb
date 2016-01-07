class MediaController < ApplicationController
  def index
    @spy = current_spy
  end
end
