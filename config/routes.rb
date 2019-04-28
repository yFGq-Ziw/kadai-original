Rails.application.routes.draw do

  root to: 'toppages#index'

  get 'categorys/:category', to: 'categorys#show'
  get 'categorys', to: 'categorys#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  get 'rankings/follow', to: 'rankings#follow'
  
  # CRUD
  put 'users/:id', to: 'users#update'
  # edit: 更新用のフォームページ
  get 'users/:id/edit', to: 'users#edit'

  resources :users, only: [:index, :show, :new, :create, :edit, :update] do
    member do
      get :followings
      get :followers
      get :likes
    end
  end

  resources :fobitows, only: [:index, :show, :create, :destroy, :edit, :update] do
    resources :favorites, only: [:create, :destroy]
    resources :comments
  end
  
  resources :relationships, only: [:create, :destroy]
end