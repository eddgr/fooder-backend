class Api::V1::MessagesController < ApplicationController
  before_action :logged_in_user

  # CREATE
  def create
    message = Message.new(message_params)

    if message.save
      chat = Restaurant.find(params[:restaurant_id])

      ChatThreadChannel.broadcast_to(chat, {
        type: 'SEND_MESSAGE', payload: {
          id: message.id,
          username: message.user.username,
          content: message.content,
          created_at: message.created_at,
          updated_at: message.updated_at,
          restaurant_id: params[:restaurant_id],
          user_id: message.user.id
        }
      })

      chat.update(updated_at: message.updated_at)

      render json: message
    end
  end

  # PRIVATE METHODS
  private

  def message_params
    params.permit(:user_id, :restaurant_id, :content)
  end
end
