class User < ApplicationRecord
  validates :username, uniqueness: true
  has_secure_password

  has_many :favorites
  has_many :restaurants, through: :favorites
  has_many :messages
  # has_many :restaurants, through: :messages
end
