class Api::V1::UsersController < ApplicationController
  # READ
  def profile
    render json: logged_in_user
  end

  def index
    users = User.all
    render json: users
  end

  # CREATE
  def create
    user = User.create(user_params)

    if user.valid?
      render json: { token: encode_token(user), id: user.id, username: user.username }
    else
      render json: { error: "Username already taken" }
    end
  end

  # PRIVATE METHODS
  private

  def user_params
    params.permit(:username, :password)
  end
end
