class User < ActiveRecord::Base
  has_many :categories
  has_many :creators, through: :categories
  has_many :tweets, through: :creators
  has_many :videos, through: :creators
  validates_presence_of :name, :uid, :provider
  validates_uniqueness_of :uid

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

 # this two methods will run for every creator we search on the search page view
 # it will choose which button to show - "Follow" or "Unfollow"

  def twitter_follow?(result)
    creator = Creator.find_by(uid: result.id, provider: "twitter")
    return true if self.creators.include?(creator)
  end

  def vimeo_follow?(result)
    creator = Creator.find_by(uid: result["uri"].gsub(/[^0-9]/, ""), provider: "vimeo")
    return true if self.creators.include?(creator)
  end

end
