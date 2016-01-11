class VimeoUser < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :videos
  validates :name, presence: true
  validates :uri, presence: true
end
