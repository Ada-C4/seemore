class Medium < ActiveRecord::Base
  belongs_to :mark

  validates :mark_id, :date_posted, :link, :medium_type, presence: true

end
