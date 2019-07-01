require 'rest-client'

class Restaurant < ApplicationRecord
  has_many :favorites
  has_many :messages
  has_many :users, through: :favorites
  # has_many :users, through: :messages

  def more_details
    # if self.tip_photo === nil

    # https://api.foursquare.com/v2/venues/537b5258498e262a54b47216&client_id=GFRYXUKB53LGZM1BJPEEECBU2SHKIDWBHBFVREJ1TFT35RUP&client_secret=KTLX5QWCKTJ0MZFRYKSQBKHZMYI2SC1BWKJ5ZZMC5KM4PICW&v=20190626

    fetch = RestClient.get("https://api.foursquare.com/v2/venues/#{self.fsq_id}?&client_id=#{ENV["FSQ_ID"]}&client_secret=#{ENV["FSQ_SECRET"]}&v=#{ENV["FSQ_VERSION"]}")

    fetch_json = JSON.parse(fetch)["response"]["venue"]
    # byebug
    self.update(
      price: fetch_json["price"]["currency"],
      tip_text: fetch_json["tips"]["groups"][0]["items"][0]["text"],
      tip_photo: "#{fetch_json["bestPhoto"]["prefix"]}500x500#{fetch_json["bestPhoto"]["suffix"]}",
      hours: [
        [fetch_json["hours"]["timeframes"][0]["days"]], [fetch_json["hours"]["timeframes"][0]["open"][0]["renderedTime"]]
      ].join(", ")
    )

    # take fetch response then update the Restaurant object with missing variables:
    # contact, price, menu, hours, tip_text, tip_photo
  end
end
