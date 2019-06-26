class Api::V1::UsersController < ApplicationController
  # READ
  def index
    users = User.all
    render json: users
  end

  # CREATE

  # PRIVATE METHODS
  private

  def user_params
    params.permit(:username, :password)
  end
end
