class Creator < ActiveRecord::Base
  validates_presence_of :name, :uid, :provider
  validates_uniqueness_of :uid
  has_many :categories
  has_many :users, through: :categories
  has_many :videos
  has_many :tweets

  def self.find_or_create(params)
    creator = self.find_by(uid: params["uid"], provider: params["provider"])
    if !creator.nil?
      return creator
    else
      Creator.transaction do
        creator = Creator.new(
            name: params["name"],
            provider: params["provider"],
            uid: params["uid"]
              )
          if creator.provider == "vimeo"
            if !params["profile_pic"].nil?
              creator.profile_pic = params["profile_pic"]["sizes"][2]["link"]
            else
              creator.profile_pic = "vimeo_default_image.png"
            end
            creator.save
            video_data_array = creator.get_videos_info
            Video.create_videos_for_creator_from_hashes(video_data_array, creator)
          elsif creator.provider == "twitter"
            if !params["profile_pic"].nil?
              creator.profile_pic = params["profile_pic"]
            else
              creator.profile_pic = "twitter_default_image.png"
            end
            creator.save
            Tweet.find_or_create_tweets(creator)
          end
        end
    end
    if creator.save
      return creator
    else
      return nil
    end
  end

  def get_videos_info
    vimeo_access_token = ENV["VIMEO_ACCESS_TOKEN"]
    videos = HTTParty.get("https://api.vimeo.com/users/#{self.uid}/videos",
      headers: {"Authorization" => "bearer #{vimeo_access_token}", 'Accept' => 'application/json' }, format: :json).parsed_response
    if videos["error"].nil?
      if videos["data"].nil?
        return nil
      else
        return videos["data"]
      end
    elsif !videos["error"].nil?
      raise ArgumentError
    end
  end


  def get_tweets
    $twitter.user_timeline(self.name).take(25)
  end

end
