class Video < ActiveRecord::Base
  belongs_to :vimeo_users
  validates :uri, presence:true
  validates :vimeo_created_at, presence: true
  validates :embed, presence: true
end
