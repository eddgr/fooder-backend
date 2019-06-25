Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index]
      resources :restaurants, only: [:index, :show]
      resources :messages, only: [:create]
    end
  end

  mount ActionCable.server => 'cable'
end
