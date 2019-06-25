class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :messages do
    object.messages.map do |message|
      message = {
        id: message.id,
        username: message.user.name,
        content: message.content,
        created_at: message.created_at
      }
    end
  end
end
