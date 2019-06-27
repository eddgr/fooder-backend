class Api::V1::RestaurantsController < ApplicationController

  # READ
  def index
    # if logged_in_user
    #   restaurants = []
    #
    #   Restaurant.all.each do |restaurant|
    #     restaurant.users.each do |user|
    #       if user.id != logged_in_user.id
    #         restaurants << restaurant
    #       end
    #     end
    #   end
    #   byebug
    #
    #   render json: restaurants
    # end
    # logged_in_user.favorites
    restaurants = Restaurant.all
    render json: restaurants
  end

  def show
    restaurant = Restaurant.find(params[:id])
    render json: restaurant
  end

end
