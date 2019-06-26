class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :show_likes, :show_dislikes

  # has_many :favorites do
  #   liked_array = object.favorites.select do |fav|
  #     fav.liked === true
  #   end
  #
  #   liked_array.map do |fav|
  #     liked = {
  #       id: fav.restaurant_id,
  #       name: fav.restaurant.name,
  #       categories: fav.restaurant.categories,
  #       fsq_id: fav.restaurant.fsq_id,
  #       location: fav.restaurant.location,
  #       messages: fav.restaurant.messages
  #     }
  #   end
  # end

end
