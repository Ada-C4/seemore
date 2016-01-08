class Spy < ActiveRecord::Base
  has_and_belongs_to_many :marks
  has_many :media, through: :marks

  validates :uid, :username, :provider, presence: true
  validates :uid, :username, uniqueness: true

  def self.find_or_create_from_omniauth(auth_hash)
    spy = self.find_by(uid: auth_hash["uid"], provider: auth_hash["provider"] )
    if !spy.nil?
      # Spy found, continue on with your life
      return spy
    elsif auth_hash["provider"] == "developer"
      # Create a new spy
      spy            = Spy.new
      spy.uid        = auth_hash["uid"]
      spy.provider   = auth_hash["provider"]
      spy.username   = auth_hash["info"]["username"]
      if !spy.image_url.present?
        spy.image_url = "blank.png"
      end
      if spy.save
        return spy
      else
        return nil
      end
    elsif auth_hash["provider"] == "twitter"
      spy            = Spy.new
      spy.uid        = auth_hash["uid"]
      spy.provider   = auth_hash["provider"]
      spy.username   = auth_hash["info"]["nickname"]
      if !spy.image_url.present?
        spy.image_url = "blank.png"
      end
      if spy.save
        return spy
      else
        return nil
      end
    elsif auth_hash["provider"] == "vimeo"
      spy            = Spy.new
      spy.uid        = auth_hash["uid"]
      spy.provider   = auth_hash["provider"]
      spy.username   = auth_hash["info"]["nickname"]
      if !spy.image_url.present?
        spy.image_url = "blank.png"
      end
      if spy.save
        return spy
      else
        return nil
      end
    end
  end
end
