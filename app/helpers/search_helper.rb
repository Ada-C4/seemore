module SearchHelper

  def twitter_result?
    params[:provider] == "1"
  end

  def vimeo_result?
    params[:provider] == "2"
  end

  def vim_base_uri
    "https://api.vimeo.com"
  end

  def vimeo_access_token
    ENV["VIMEO_ACCESS_TOKEN"]
  end

end
