class User < ActiveRecord::Base
  validates :name, presence: true
  has_many :identities
  has_and_belongs_to_many :handles
  has_many :media, through: :handles

  def self.create_with_omniauth(info)
    create(name: info["name"])
  end

  def find_vimeo_handles
    self.handles.find_all do |handle|
      handle.provider == "vimeo"
    end
  end

  def find_twitter_handles
    self.handles.find_all do |handle|
      handle.provider == "twitter"
    end
  end

  def merge_user_accounts(other_account)
    self.handles += other_account.handles
    other_account.destroy
  end
end
