Rails.application.routes.draw do
  resource :profile, only: [:new, :create, :show]

  resource :user_session, only: [:new, :create, :destroy]

  resources :users, only: [:index, :edit, :update] do
    resource :block, only: :create
  end
end
