class Api::V1::MessagesController < ApplicationController
  def create
    message = Message.new(message_params)

    if message.save
      ActionCable.server.broadcast("chat_channel", {
        type: 'SEND_MESSAGE', payload: {
          id: message.id,
          username: message.user.name,
          content: message.content
        }
      })

      render json: message
    end
  end

  private

  def message_params
    params.permit(:user_id, :restaurant_id, :content)
  end
end
