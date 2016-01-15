class User < ActiveRecord::Base
  validates :name, :uid, :provider, presence: true
  has_and_belongs_to_many :creators
  has_many :content, :through => :creators

  def self.find_or_create_from_omniauth(auth_hash)
    user = self.find_by(uid: auth_hash["uid"], provider: auth_hash["provider"])
    if !user.nil?
      return user
    else
      user = User.new
      user.uid        = auth_hash["uid"]
      user.provider   = auth_hash["provider"]
      user.name       = auth_hash["info"]["name"]
      if user.save
        user
      else
        nil
      end
    end
  end

  # method checks if the user is already following the creator
  # returns creator object/nil and boolean indicating whether user is already following creator
  def following(provider, p_id)
    creator = Creator.where("provider = ? AND p_id = ?", provider, p_id).first
    if creator.nil?
      # creator does not exist and user is not following it
      return nil, false
    elsif creators.include?(creator)
      # creator exists and user is following it
      return creator, true
    else
      # creator exists but user not following it
      return creator, false
    end
  end
end
