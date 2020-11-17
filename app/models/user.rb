class User < ApplicationRecord
  has_secure_password
  has_many :tracks, dependent: :destroy
  has_many :records, dependent: :destroy
  validates :name, presence: true
  validates :email, uniqueness: true
end
