class VimeoUser < ActiveRecord::Base
  has_and_belongs_to_many :users
  validates :vimeo_id, presence: true
  validates :name, presence: true
  validates :uri, presence: true
end
