Rails.application.routes.draw do
  resources :confirmations, only: :show

  resource :version, only: :show

  resources :products, only: %i(index show) do
    resources :similarities, only: :index
  end

  resources :categories, only: %i(index create) do
    resources :products, only: :index
  end

  resources :orders, :users, only: :create

  resources :purchases, only: %i(create update destroy)

  resource :session, only: %i(create destroy)

  namespace :facebook do
    resource :session, only: %i(create destroy)
  end
end
