Rails.application.routes.draw do
  resource :profile, only: [:new, :create, :show]
end
