class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :fsq_id, :location, :categories, :lat, :long, :updated_at, :contact, :price, :menu, :hours, :tip_text, :tip_photo

  has_many :favorites do
    object.favorites.map do |favorite|
      if favorite.liked
        favorite.user.id
      end
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
