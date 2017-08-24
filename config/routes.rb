Rails.application.routes.draw do
  root to: 'profiles#show'

  resource :profile, only: [:new, :create, :show]

  resources :purchases, only: [:create, :update, :destroy]

  resources :orders, only: :create

  resources :confirmations, only: [:show, :index]

  resource :session, only: [:new, :create, :destroy]
  
  resources :products

  resources :users, only: [:index, :edit, :update] do
    resource :block, only: [:create, :destroy]
  end

  resources :categories, only: :index

  resources :widgets, only: :index
end
