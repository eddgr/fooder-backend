class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :fsq_id, :location, :categories

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
