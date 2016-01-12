class Video < ActiveRecord::Base
  belongs_to :creator
  validates :name, :uri, :embed, :vimeo_id, :posted_at,
   presence: true

end
