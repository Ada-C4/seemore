class Subscription < ActiveRecord::Base
  validates :username, :uid, :provider, presence:true
end
