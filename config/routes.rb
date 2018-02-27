Rails.application.routes.draw do
  root to: "home#show"

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :sessions, only: [:create, :destroy]
  resource :home, only: [:show]

  resources :appointments, only: [:index, :new, :create, :edit, :update, :destroy]

  get '/events/:calendar_id', to: 'appointments#events', as: 'events', calendar_id: /[^\/]+/
  post '/events/:calendar_id', to: 'appointments#new_event', as: 'new_event', calendar_id: /[^\/]+/
end
