class Content < ActiveRecord::Base
  belongs_to :creator
  validates :content_id, :text, :create_time, :creator_id, presence: true

end
