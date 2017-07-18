Rails.application.routes.draw do
  resource :profile, only: [:new, :create, :show] do
    resources :purchases, only: [:create]
  end

  resources :confirmations, only: [:show, :index]

  resource :session, only: [:new, :create, :destroy]
  
  resources :products

  resources :users, only: [:index, :edit, :update] do
    resource :block, only: [:create, :destroy]
  end
end
