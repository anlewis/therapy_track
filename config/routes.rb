Rails.application.routes.draw do
  root to: "home#show"

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :sessions, only: [:create, :destroy]
  resource :home, only: [:show]

  resources :appointments, only: [:index, :new, :create, :edit, :destroy, :update]
  # put '/appointments/:calendar_id', to: 'appointments#update', calendar_id: /[^\/]+/
end
