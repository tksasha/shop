Rails.application.routes.draw do
  resource :profile, only: [:new, :create, :show]

  resources :purchases, only: [:create, :update, :destroy]

  resources :confirmations, only: [:show, :index]

  resource :session, only: [:new, :create, :destroy]
  
  resources :products

  resources :users, only: [:index, :edit, :update] do
    resource :block, only: [:create, :destroy]
  end
end
