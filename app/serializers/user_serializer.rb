class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :show_likes, :show_dislikes, :lat, :long

end
