class Api::V1::FavoritesController < ApplicationController
  # CREATE
  def create
    liked = Favorite.create(user_id: params[:user_id], restaurant_id: params[:restaurant_id], liked: params[:liked])

    render json: liked
  end

  # PRIVATE METHODS
  private

  def fav_params
    params.permit(:user_id, :restaurant_id, :liked)
  end
end
