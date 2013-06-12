class Community < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  attr_accessible :name

  has_many :categories, inverse_of: :community, dependent: :destroy

  validates :name, presence: true
end