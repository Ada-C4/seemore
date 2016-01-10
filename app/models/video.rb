class Video < ActiveRecord::Base
  belongs_to :vimeo_users
  validates :title, presence: true
  validates :uri, presence:true
end
