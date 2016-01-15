class Video < ActiveRecord::Base
  belongs_to :creator
  validates_presence_of :uri, :embed, :vimeo_id, :posted_at
  validates_uniqueness_of :uri

  def self.create_videos_for_creator_from_hashes(video_data_array, creator)
    if !video_data_array.nil?
      video_data_array.each do |video_hash|
       video_id = video_hash["uri"].gsub(/[^0-9]/, "")
       vid = Video.new ({
       uri: "#{video_hash["uri"]}",
       name: "#{video_hash["name"]}",
       description: "#{video_hash["description"]}",
       embed: "https:\/\/player.vimeo.com\/video\/#{video_id}",
       posted_at: "#{video_hash["created_time"]}",
       vimeo_id: "#{video_id}"
      })
       vid.creator_id = creator.id
       vid.save
      end
    else
      return nil
    end
  end

end
