class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat_thread
end
