Rails.application.routes.draw do
  resource :profile, only: [:new, :create, :show]

  resource :session, only: [:new, :create, :destroy]
end
