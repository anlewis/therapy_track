Rails.application.routes.draw do
  root to: "home#show"

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'about', to: 'about#index'

  resources :sessions, only: [:create, :destroy]
  resource :home, only: [:show]

  resources :appointments, only: [:index, :new, :create, :edit, :destroy, :update]

  resources :reports do
    resources :medical_reports, only: [:new, :create]
    get 'submit', to: 'submission#show'
    put 'submit', to: 'submission#update'
  end
end