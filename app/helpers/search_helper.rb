module SearchHelper

  def twitter_result?
    params[:provider] == "1"
  end

  def vimeo_result?
    params[:provider] == "2"
  end


end
