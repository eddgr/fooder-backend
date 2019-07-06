class Api::V1::RestaurantsController < ApplicationController
  before_action :logged_in_user

  # READ
  def index
    if !!logged_in_user.lat && !!logged_in_user.long
      # check to see if current user has lat/long coordinates

      # if so, run through all restaurants and check if they're within 25 miles from user
      check_restaurants = Restaurant.all.select {|restaurant| restaurant if Geocoder::Calculations.distance_between([logged_in_user.lat, logged_in_user.long], [restaurant.lat, restaurant.long]) <= 25}

      # then check if there is at least 10 venues
      if check_restaurants.length <= 10
        # if less than 10, find more users
        Restaurant.find_venues(logged_in_user.lat, logged_in_user.long)

        # return the updated venues
        restaurants = Restaurant.all
      else
        # returns the current venues before calling Restaurant.find_venues
        restaurants = Restaurant.all
      end
    else
      # returns the normal venues list
      restaurants = Restaurant.all
    end

    render json: restaurants
  end

  def show
    restaurant = Restaurant.find(params[:id])

    if restaurant.tip_photo === nil
      restaurant.more_details
    end

    render json: restaurant
  end

end
