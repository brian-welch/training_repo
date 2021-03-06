Rails.application.routes.draw do


  # get 'session_cardio_bout/index'
  # get 'session_cardio_bout/new'
  # get 'session_cardio_bout/create'
  get 'user_weights/show'
  get 'user_weights/new'
  devise_for :users,
             :controllers => { :registrations => "my_devise/registrations" }

  root to: 'pages#home'

  get 'home', to: 'pages#home'
  get 'about', to: 'pages#about'
  get 'inactive', to: 'pages#inactive'
  get 'your_privacy', to: 'pages#your_privacy'

  get 'contact_us', to: 'pages#contact_us'

  get 'my_tr', to: 'dashboards#index', as: "my_tr"

  resources :training_sessions
  resources :session_sets, only: [:index, :new, :create]
  resources :session_cardio_bouts, only: [:index, :new, :create]
  resources :session_strategies

  resources :brands
  resources :machines

  resources :exercises

  resources :user_weights, only: [:new, :show]

end
