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
    else
      # Create a new spy
      spy            = Spy.new
      spy.uid        = auth_hash["uid"]
      spy.provider   = auth_hash["provider"]
      spy.username   = auth_hash["info"]["username"]
      spy.image_url = auth_hash["info"]["image"]
      if spy.save
        return spy
      else
        return nil
      end
    end
  end
end
