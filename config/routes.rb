Rails.application.routes.draw do
  resource :profile, only: [:new, :create, :show]

  resource :session, only: [:new, :create, :destroy]
  
  resources :products, only: [:index,  :new, :create]

  resources :users, only: [:index, :edit, :update] do
    resource :block, only: [:create, :destroy]
  end
end
