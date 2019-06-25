class Api::V1::UsersController < ApplicationController
  def index
    users = User.all

    ActionCable.server.broadcast("chat_channel", users)

    render json: users
  end
end
