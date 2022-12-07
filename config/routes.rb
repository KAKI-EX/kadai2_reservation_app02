Rails.application.routes.draw do
  devise_for :users #devise用記述

  root "homes#index"
  resources :posts

  resources :homes,except: [:new, :update] do
    collection do
      get 'confirmation', to: 'homes#confirmation'                   #予約確認画面リロードエラー対策のために記述
      post 'confirmation', to: 'homes#confirmation'                   #予約確認画面
      get 'confirmed/:id', to: 'homes#confirmed', as: 'confirmed'     #予約完了画面
      get 'search_result', to: 'homes#search_result'                  #検索結果画面
      get 'search'                                                    #ransack用記述
      get 'new/:id', to: 'homes#new', as: 'new'                       #新規予約画面
      get 'edit_confirmation/:id', to: 'homes#edit_confirmation', as: 'edit_confirmation2'  #予約確認画面リロードエラー対策のために記述
      patch 'edit_confirmation/:id', to: 'homes#edit_confirmation', as: 'edit_confirmation'  #予約編集確認画面
      patch '/:id' ,to: 'homes#update', as: 'update'                  #updateアクションがエラー。明示的に変更。
    end
  end
end
