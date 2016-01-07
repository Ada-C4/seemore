class User < ActiveRecord::Base
  has_many :identities
  has_and_belongs_to_many :handles
  has_many :media, through: :handles

  def self.create_with_omniauth(info)
    create(name: info["name"])
  end
end
