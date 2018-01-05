Rails.application.routes.draw do
  root to: redirect('/boards')

  devise_for :users

  resources :users, only: [:show] do
    get :search, on: :collection
  end
  resources :notifications, only: [:index, :show]
  resources :boards do
    resources :topics do
      resources :posts, only: [:create, :update, :destroy] do
        get :fetch, on: :member
      end
    end
  end
end
