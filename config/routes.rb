Rails.application.routes.draw do
  root to: 'home#show'

  resource :profile, only: [:new, :create, :show, :edit, :update]

  resources :purchases, only: [:create, :update, :destroy]

  resources :orders, only: :create

  resources :confirmations, only: [:show, :index]

  resource :session, only: [:new, :create, :destroy]
  
  resources :products

  resources :users, only: [:index, :edit, :update] do
    resource :block, only: [:create, :destroy]
  end

  resources :categories, only: %i(index edit)

  resources :widgets, only: :index

  resource :version, only: :show
end
