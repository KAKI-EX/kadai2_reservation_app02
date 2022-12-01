Rails.application.routes.draw do
  devise_for :users #devise用記述

  root "homes#index"
  resources :posts

  resources :homes,except:[:new,:edit] do
    collection do
      post 'confirmation', to: 'homes#confirmation'                   #予約確認画面
      get 'confirmed/:id', to: 'homes#confirmed', as: 'confirmed'     #予約完了画面
      get 'search_result', to: 'homes#search_result'                  #検索結果画面
      get 'search'                                                    #ransack用記述
      get 'new/:id', to: 'homes#new', as: 'new'                       #新規予約画面
      post 'homes/back'                                               #予約確認画面から新規予約画面へ戻るアクション
      get 'edit/:id', to:'homes#edit',as: 'edit'
    end
  end
end
