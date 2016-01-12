class MediaController < ApplicationController
  def index
    if !current_spy.nil?
      @marks = current_spy.marks
      @media = Medium.all # sort by date
    end
  end
end
