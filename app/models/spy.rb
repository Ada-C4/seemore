class Spy < ActiveRecord::Base
  has_and_belongs_to_many :marks
  has_many :media, through: :marks

  validates :uid, :username, :provider, presence: true
  validates :uid, :username, uniqueness: true
end
