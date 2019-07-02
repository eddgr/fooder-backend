class User < ApplicationRecord
  validates :username, uniqueness: true, length: { minimum: 3 }
  # validates :password, length: { in: 5..20 }

  has_secure_password

  has_many :favorites
  has_many :restaurants, through: :favorites
  has_many :messages

  # HELPER METHODS
  def mapRestaurant(array)
    array.map do |fav|
      liked = {
        id: fav.restaurant_id,
        name: fav.restaurant.name,
        categories: fav.restaurant.categories,
        updated_at: fav.restaurant.updated_at,
        favorites: fav.restaurant.favorites.map do |f|
          if f.liked
            f.id
          end
        end.reject(&:nil?),
        dislikes: fav.restaurant.dislikes,
        fsq_id: fav.restaurant.fsq_id,
        tip_photo: fav.restaurant.tip_photo,
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
