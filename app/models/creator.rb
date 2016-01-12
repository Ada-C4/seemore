class Creator < ActiveRecord::Base
  has_many :categories
  has_many :users, through: :categories
  has_many :videos
  has_many :tweets

  def add_videos
    vimeo_access_token = ENV["VIMEO_ACCESS_TOKEN"]
    videos = HTTParty.get("https://api.vimeo.com/#{self.uri}/videos",
      headers: {"Authorization" => "bearer #{vimeo_access_token}", 'Accept' => 'application/json' }, format: :json).parsed_response
    if !videos["data"].nil?
      videos["data"].each do |video_json|
        video_id = video_json["uri"].gsub(/[^0-9]/, "")
        vid = Video.new ({
        uri: "#{video_json["uri"]}",
        name: "#{video_json["name"]}",
        description: "#{video_json["description"]}",
        embed: "https:\/\/player.vimeo.com\/video\/#{video_id}",
        posted_at: "#{video_json["created_time"]}", 
        vimeo_id: "#{video_id}"
      })
        vid.creator_id = self.id
        vid.save
      end
    end
  end

  def add_tweets
    
  end

end
