Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root "homes#index"
  resources :posts

  resources :homes do
    collection do
      get 'confirmation', to: 'homes#confirmation'
      get 'confirmed', to: 'homes#confirmed'
      get 'user_reservation_list', to: 'homes#user_reservation_list'
      get 'search_result', to: 'homes#search_result'
      get 'search'
    end
  end

end
