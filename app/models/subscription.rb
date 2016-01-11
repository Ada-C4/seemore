class Subscription < ActiveRecord::Base
  validates :username, :uid, :provider, presence:true
  has_many :stories
  has_and_belongs_to_many :users

  def self.find_or_create(uid, provider, username, avatar_url)
    subscription = self.find_by(uid: uid, provider: provider)
    if !subscription.nil?
      #subscription found continue on with your life
      return subscription
    else
      #create a new subscription
      subscription = Subscription.new
      subscription.uid = uid
      subscription.provider = provider
      subscription.username = username
      subscription.avatar_url = avatar_url
      if subscription.save
        return subscription
      else
        return nil
      end
    end
  end

  def self.find(uid, provider)
    subscription = self.find_by(uid: uid, provider: provider)
    if !subscription.nil?
      #subscription found continue on with your life
      return subscription
    else
      return nil
    end
  end
end
