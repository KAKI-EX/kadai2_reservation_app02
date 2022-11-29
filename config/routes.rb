Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root "homes#index"
  resources :posts

  resources :homes do
    collection do
      post 'confirmation', to: 'homes#confirmation'                   #予約確認画面
      post 'confirmed', to: 'homes#confirmed'                          #予約完了画面
      get 'user_reservation_list', to: 'homes#user_reservation_list'  #予約確認一覧
      get 'search_result', to: 'homes#search_result'                  #検索結果画面
      get 'search'                                                    #ransack用記述
      get 'homes/new/:id', to: 'homes#new', as: 'new'                 #新規予約画面
      post 'homes/back'
    end
  end
end
