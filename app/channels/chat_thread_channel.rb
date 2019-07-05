class ChatThreadChannel < ApplicationCable::Channel
  def subscribed
    chat = Restaurant.find(params["restaurant_id"])
    stream_for chat
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    # raise "?"
  end
end
