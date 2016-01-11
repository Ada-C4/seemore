class MediaController < ApplicationController
  def index
    if !current_spy.nil?
      @marks = current_spy.marks
    end
  end

  def embed_tweets(mark)
    

  end
end
