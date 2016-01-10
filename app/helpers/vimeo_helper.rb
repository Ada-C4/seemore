module VimeoHelper

  VIMEO_MAX_WIDTH = "500px"
  VIMEO_MAX_HEIGHT = "450px"

  def vimeo_auth
    "bearer #{vimeo_access_token}"
  end

  def vim_base_uri
    "https://api.vimeo.com"
  end

  def vimeo_access_token
    ENV["VIMEO_ACCESS_TOKEN"]
  end

  def get_video(video_id)
    HTTParty.get( "https://vimeo.com/api/oembed.json?url=https%3A//vimeo.com/#{video_id}&maxwidth=#{VIMEO_MAX_WIDTH}&maxheight=#{VIMEO_MAX_HEIGHT}", headers: {"Authorization" => vimeo_auth, 'Accept' => 'application/json' }, format: :json).parsed_response
  end

end
