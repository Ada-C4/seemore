class Video < ActiveRecord::Base
  belongs_to :vimeo_users
  validates :uri, presence:true
end
