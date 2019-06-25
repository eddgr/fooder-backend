class User < ApplicationRecord
  has_many :favorites
  has_many :restaurants, through: :favorites
  has_many :messages
  # has_many :restaurants, through: :messages
end
