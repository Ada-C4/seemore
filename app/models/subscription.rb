class Subscription < ActiveRecord::Base
  validates :username, :uid, :provider, presence:true
  has_many :stories
  has_and_belongs_to_many :users
end
