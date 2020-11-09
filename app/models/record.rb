class Record < ApplicationRecord
  belongs_to :track
  validates :value, presence: true
end
