class User < ApplicationRecord
  validates :username, uniqueness: true
  has_secure_password

  has_many :favorites
  has_many :restaurants, through: :favorites
  has_many :messages
  # has_many :restaurants, through: :messages

  # HELPER METHODS
  def mapRestaurant(array)
    array.map do |fav|
      liked = {
        id: fav.restaurant_id,
        name: fav.restaurant.name,
        categories: fav.restaurant.categories,
        fsq_id: fav.restaurant.fsq_id,
        location: fav.restaurant.location,
        messages: fav.restaurant.messages
      }
    end
  end
  
  def show_likes
    liked = self.favorites.find_all do |favorite|
      favorite.liked === true
    end

    mapRestaurant(liked)
  end

  def show_dislikes
    disliked = self.favorites.find_all do |favorite|
      favorite.liked === false
    end
    mapRestaurant(disliked)
  end
end
