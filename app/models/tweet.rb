class Tweet < ActiveRecord::Base
  belongs_to :twitter_users
  validates :twitter_id, presence: true
  validates :text, presence: true
  validates :uri, presence: true
  validates :twitter_created_at, presence: true
  validate :embed, presence: true
end
