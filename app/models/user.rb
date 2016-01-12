class User < ActiveRecord::Base
  has_many :categories
  has_many :creators, through: :categories
  validates :name, :uid, :provider,
   presence: true

 def self.find_or_create_from_omniauth(auth_hash)
   user = self.find_by(uid: auth_hash["uid"], provider: auth_hash["provider"])
   if !user.nil?
     # User found continue on with your life
     return user
   else
     # Create a new user
     user = User.new
     user.uid        = auth_hash["uid"]
     user.provider   = auth_hash["provider"]
     user.name   = auth_hash["info"]["name"]
     user.email      = auth_hash["info"]["email"]
     if user.provider == "twitter"
       user.avatar_url = auth_hash["info"]["image"]
     elsif user.provider == "vimeo"
       user.avatar_url = auth_hash["info"]["pictures"][2]["link"] if auth_hash["info"]["pictures"]
     end
     if user.save
       return user
     else
       return nil
     end
   end
 end

 def videos
  videos = []
   self.creators.each do |creator|
    if creator.provider == "vimeo"
      creator.videos.each do |video|
        videos << video
      end
    end
   end
   return videos
 end

end
