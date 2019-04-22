Rails.application.routes.draw do

  root to: 'toppages#index'

  get 'categorys/:category', to: 'categorys#show'

#  get "toppages/bookmark" => "toppages#bookmark"

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  get 'rankings/follow', to: 'rankings#follow'
  
  # CRUD
  put 'users/:id', to: 'users#update'
  # edit: 更新用のフォームページ
  get 'users/:id/edit', to: 'users#edit'

#  get '/post/tag/:name', to: "fobitows#tag"

#  resources :tags, only: [:index, :show]
  
  resources :users, only: [:index, :show, :new, :create, :edit, :update] do
    member do
      get :followings
      get :followers
      get :likes
    end
  end

  # ajax
  resources :fobitows do
    resources :favorites, only: [:create, :destroy]
  end
  # ajaxここまで
  
  resources :relationships, only: [:create, :destroy]
end