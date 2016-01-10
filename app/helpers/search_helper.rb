module SearchHelper
  VIMEO_BASE_URI = "https://api.vimeo.com"

  def twitter_result?
    params[:provider] == "1"
  end

  def vimeo_result?
    params[:provider] == "2"
  end

end
