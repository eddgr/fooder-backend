class Api::V1::MessagesController < ApplicationController

  # CREATE
  def create
    message = Message.new(message_params)

    if message.save
      chat = Restaurant.find(params[:restaurant_id])

      ChatThreadChannel.broadcast_to(chat, {
        type: 'SEND_MESSAGE', payload: {
          id: message.id,
          username: message.user.username,
          content: message.content
        }
      })

      render json: message
    end
  end

  # PRIVATE METHODS
  private

  def message_params
    params.permit(:user_id, :restaurant_id, :content)
  end
end
