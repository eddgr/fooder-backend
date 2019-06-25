class User < ApplicationRecord
  has_many :chat_threads
  has_many :messages, through: :chat_threads
end
