class Track < ApplicationRecord
  belongs_to :user
  has_many :records, dependent: :destroy
  validates :name, presence: true
end
