Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'

  get 'about', to: 'pages#about'

  get 'my_tr', to: 'dashboards#index', as: "my_tr"

  resources :training_sessions
  resources :session_exercises
  resources :session_strategies

  resources :brands
  resources :machines

end
