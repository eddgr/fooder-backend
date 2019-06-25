Rails.application.routes.draw do
  get '/users', to: 'users#index'
  mount ActionCable.server => 'cable'
end
