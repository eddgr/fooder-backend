Rails.application.routes.draw do
  post '/profile', to: 'api/v1/users#profile'

  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      resources :restaurants, only: [:index, :show]
      resources :messages, only: [:create]
    end
  end

  mount ActionCable.server => 'cable'
end
