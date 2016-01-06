class User < ActiveRecord::Base
  validates :uid, :provider, :username, presence: true
end
