class User < ApplicationRecord
  has_secure_password
  has_many :records, dependent: :destroy
  has_many :tracks, dependent: :destroy
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
