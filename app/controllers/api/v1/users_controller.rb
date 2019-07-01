class Api::V1::UsersController < ApplicationController
  before_action :logged_in_user, except: [:create]

  # READ
  def index
    users = User.all
    render json: users
  end

  # CREATE
  def create
    user = User.create(user_params)

    if user.valid?
      user.update(lat: params[:lat], long: params[:long])
      
      render json: { token: encode_token(user), id: user.id, username: user.username, lat: user.lat, long: user.long }
    else
      render json: { error: "Username already taken" }
    end
  end

  # UPDATE
  def profile
    logged_in_user.update(lat: params[:lat], long: params[:long])

    if logged_in_user.save
      render json: logged_in_user
    end
  end

  # PRIVATE METHODS
  private

  def user_params
    params.permit(:username, :password, :lat, :long)
  end
end
