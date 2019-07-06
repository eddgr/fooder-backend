require 'rest-client'

class Restaurant < ApplicationRecord
  has_many :favorites
  has_many :messages
  has_many :users, through: :favorites
  # has_many :users, through: :messages

  # INSTANCE METHODS
  def dislikes
    self.favorites.map do |fav|
      # byebug
      if fav.liked === false
        fav.user_id
      end
    end.reject(&:nil?)
  end

  def more_details
    fetch = RestClient.get("https://api.foursquare.com/v2/venues/#{self.fsq_id}?&client_id=#{ENV["FSQ_ID"]}&client_secret=#{ENV["FSQ_SECRET"]}&v=#{ENV["FSQ_VERSION"]}")

    fetch_json = JSON.parse(fetch)["response"]["venue"]

    if fetch_json["hours"]
      self.update(
        tip_text: fetch_json["tips"]["groups"][0]["items"][0]["text"],
        tip_photo: "#{fetch_json["bestPhoto"]["prefix"]}500x500#{fetch_json["bestPhoto"]["suffix"]}",
        hours: [
          [fetch_json["hours"]["timeframes"][0]["days"]], [fetch_json["hours"]["timeframes"][0]["open"][0]["renderedTime"]]
        ].join(", ")
      )
    else
      self.update(
        price: fetch_json["price"]["currency"],
        tip_text: fetch_json["tips"]["groups"][0]["items"][0]["text"],
        tip_photo: "#{fetch_json["bestPhoto"]["prefix"]}500x500#{fetch_json["bestPhoto"]["suffix"]}"
      )
    end

    # take fetch response then update the Restaurant object with missing variables:
    # contact, price, menu, hours, tip_text, tip_photo
  end

  # CLASS METHODS
  def self.find_venues(lat, long)
    fetch = RestClient.get("https://api.foursquare.com/v2/venues/explore?section=food&ll=#{lat},#{long}&client_id=#{ENV["FSQ_ID"]}&client_secret=#{ENV["FSQ_SECRET"]}&v=#{ENV["FSQ_VERSION"]}&radius=100000")

    fetch_json = JSON.parse(fetch)["response"]["groups"][0]["items"]

    fetch_json.each do |data|
      # check if venue already exist in database by fsq_id
      if !Restaurant.find_by(fsq_id: data["venue"]["id"])
        # create new venue if fsq_id not found
        Restaurant.find_or_create_by(
          fsq_id: data["venue"]["id"],
          name: data["venue"]["name"],
          location: data["venue"]["location"]["formattedAddress"].join(", "),
          lat: data["venue"]["location"]["lat"],
          long: data["venue"]["location"]["lng"],
          categories: data["venue"]["categories"][0]["pluralName"]
        )
      end
    end
  end 

end
