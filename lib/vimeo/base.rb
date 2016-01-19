module Vimeo
  class Base
    BASE_URI = "https://api.vimeo.com"
    HEADERS = { "Authorization" => "bearer #{ENV['VIMEO_ACCESS_TOKEN']}" }
  end
end
