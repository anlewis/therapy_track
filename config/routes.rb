Rails.application.routes.draw do
  root to: "home#show"

  # google OAuth 2.0
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :sessions, only: [:create, :destroy]
  resource :home, only: [:show]

  get '/redirect', to: 'home#redirect', as: 'redirect'
  get '/callback', to: 'home#callback', as: 'callback'
  # view calendar list
  get '/calendars', to: 'home#calendars', as: 'calendars'
  # view event list for a calendar
  get '/events/:calendar_id', to: 'home#events', as: 'events', calendar_id: /[^\/]+/
  # add event to calendar
  post '/events/:calendar_id', to: 'home#new_event', as: 'new_event', calendar_id: /[^\/]+/
end
