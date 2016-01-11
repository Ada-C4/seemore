class TwitterUser < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :tweets
  validates :twitter_id, presence: true
  validates :screen_name, presence: true
  validates :uri, presence: true
end
