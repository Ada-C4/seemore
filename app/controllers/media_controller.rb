class MediaController < ApplicationController

  def index
    if !current_spy.nil?
      @marks = current_spy.marks
      if params[:filter] == "vimeo"
        @media = Medium.vimeo_filter(current_spy.media)
      elsif params[:filter] == "twitter"
        @media = Medium.twitter_filter(current_spy.media)
      else
        @media = Medium.no_filter(current_spy.media)
      end
    end
  end

  def refresh
    @marks = current_spy.marks
    @marks.each do |mark|
      mark.refresh
    end
    redirect_to root_path
  end
end
