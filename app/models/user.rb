class User < ApplicationRecord
  has_secure_password
  has_many :tracks, dependent: :destroy
  validates :name, presence: true
end
