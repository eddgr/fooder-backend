class Restaurant < ApplicationRecord
  has_many :favorites
  has_many :messages
  has_many :users, through: :favorites
  # has_many :users, through: :messages
end
