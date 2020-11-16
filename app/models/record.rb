class Record < ApplicationRecord
  belongs_to :track
  belongs_to :user
  validates :value, presence: true
end
