class Mark < ActiveRecord::Base
  has_and_belongs_to_many :spies
  has_many :media

  validates :username, :provider, :uid, presence: true
  validates :username, :uid, uniqueness: true
end
