Rails.application.routes.draw do
  root to: "home#show"

  # google OAuth 2.0
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :sessions, only: [:create, :destroy]
  resource :home, only: [:show]

  get '/redirect', to: 'appointments#redirect', as: 'redirect'
  get '/callback', to: 'appointments#callback', as: 'callback'
  # view calendar list
  get '/calendars', to: 'appointments#calendars', as: 'calendars'
  # view event list for a calendar
  get '/events/:calendar_id', to: 'appointments#events', as: 'events', calendar_id: /[^\/]+/
  # add event to calendar
  post '/events/:calendar_id', to: 'appointments#new_event', as: 'new_event', calendar_id: /[^\/]+/
end
