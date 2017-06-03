Rails.application.routes.draw do
  resource :profile, only: [:new, :create, :show]

  resource :session, only: [:new, :create]

  resources :users, only: [:index, :edit, :update]
end
