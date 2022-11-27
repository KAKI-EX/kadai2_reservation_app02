Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root "home#index"
  resources :posts

  resources :homes do
    collection do
      get 'confirmation', to: 'homes#confirmation'
      get 'confirmed', to: 'homes#confirmed'
      get 'user_reservation_list', to: 'home#user_reservation_list'
    end
  end

end
