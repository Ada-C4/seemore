class Tweet < ActiveRecord::Base
  belongs_to :twitter_users
  validates :twitter_id, presence: true
  validates :text, presence: true
  validates :uri, presence: true
  validates :provider_created_at, presence: true
  validates :embed, presence: true
end
