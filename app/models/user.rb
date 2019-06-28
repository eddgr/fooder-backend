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
        favorites: fav.restaurant.favorites.map do |f|
          if f.liked
            f.id
          end
        end,
        fsq_id: fav.restaurant.fsq_id,
        location: fav.restaurant.location,
        messages: fav.restaurant.messages.map do |m|
          message = {
            id: m.id,
            created_at: m.created_at,
            updated_at: m.updated_at,
            restaurant_id: m.restaurant_id,
            user_id: m.user_id,
            user_name: m.user.username,
            content: m.content
          }
        end
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
