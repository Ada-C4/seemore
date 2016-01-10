module VimeoHelper

  VIMEO_MAX_WIDTH = "350px"
  VIMEO_MAX_HEIGHT = "200px"

  def vimeo_auth
    "bearer #{vimeo_access_token}"
  end

  def vim_base_uri
    "https://api.vimeo.com"
  end

  def vimeo_access_token
    ENV["VIMEO_ACCESS_TOKEN"]
  end

end
