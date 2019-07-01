class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :fsq_id, :location, :categories, :lat, :long, :updated_at

  has_many :favorites do
    object.favorites.map do |favorite|
      # favorite = {
        # user_id: favorite.user.id,
      if favorite.liked
        favorite.user.id
      end
        # username: favorite.user.username,
        # liked: favorite.liked
      # }
    end
  end

  has_many :messages do
    object.messages.map do |message|
      message = {
        id: message.id,
        username: message.user.username,
        content: message.content,
        created_at: message.created_at
      }
    end
  end
end
