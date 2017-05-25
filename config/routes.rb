Rails.application.routes.draw do
  resources :profiles, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :show]
end
