Rails.application.routes.draw do
  devise_for :users #devise用記述

  root "homes#index"
  resources :posts

  resources :homes,except: [:new, :update] do
    collection do
      post 'confirmation', to: 'homes#confirmation'                   #予約確認画面
      get 'confirmed/:id', to: 'homes#confirmed', as: 'confirmed'     #予約完了画面
      get 'search_result', to: 'homes#search_result'                  #検索結果画面
      get 'search'                                                    #ransack用記述
      get 'new/:id', to: 'homes#new', as: 'new'                       #新規予約画面
      post 'homes/back'                                               #予約確認画面から新規予約画面へ戻るアクション
      patch 'edit_confirmation/:id', to: 'homes#edit_confirmation', as: 'edit_confirmation'  #予約編集確認画面
      post 'edit_back'                                          #予約編集確認画面からedit画面へ戻るアクション
      patch '/:id' ,to: 'homes#update', as: 'update'                  #updateアクションがエラー。明示的に変更。

    end
  end
end
