class Api::V1::RestaurantsController < ApplicationController
  before_action :logged_in_user
  
  # READ
  def index
    restaurants = Restaurant.all
    render json: restaurants
  end

  def show
    restaurant = Restaurant.find(params[:id])
    render json: restaurant
  end

end
