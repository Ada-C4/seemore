class InstagramUser < ActiveRecord::Base
  has_and_belongs_to_many :users
  validates :instagram_id, presence: true
  validates :screen_name, presence: true
  validates :uri, presence: true
end
