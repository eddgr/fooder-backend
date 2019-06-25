class ApplicationController < ActionController::API
  # encode token
  def user_payload(user)
    { user_id: user.id }
  end

   # JWT.encode accepted three arguments: payload, secret_key, encode_method
  def encode_token(user)
    JWT.encode(user_payload(user), ENV['SECRET_KEY'], 'HS256')
  end

  # decode token
  def token
    request.headers["Authorization"]
  end

  def decoded_token
    JWT.decode token, ENV['SECRET_KEY'], true, { algorithm: 'HS256' }
  end

  def logged_in_user
    User.find(decoded_token[0]["user_id"])
  end
end
