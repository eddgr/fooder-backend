class Api::V1::AuthController < ApplicationController
  def login
    user = User.find_by(username: params["username"])

    if user
      is_authenticated = user.authenticate(params["password"])
    else
      is_authenticated = false
    end

    if is_authenticated
      render json: { token: encode_token(user), id: user.id, username: user.username, show_likes: user.show_likes, show_dislikes: user.show_dislikes }
    else
      render json: { error: "Wrong username or password" }
    end
  end
end
