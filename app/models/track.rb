class Track < ApplicationRecord
  belongs_to :user
  has_many :records
  validates :name, presence: true
end
