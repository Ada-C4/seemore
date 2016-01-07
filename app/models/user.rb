class User < ActiveRecord::Base
  validates :name, presence: true
  validates :uid, presence:true, uniqueness: true
  validates :provider, presence: true
  


end
