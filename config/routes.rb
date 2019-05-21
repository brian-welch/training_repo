Rails.application.routes.draw do


  devise_for :users
  root to: 'pages#home'

  get 'home', to: 'pages#home'
  get 'about', to: 'pages#about'
  get 'inactive', to: 'pages#inactive'

  get 'contact_us', to: 'pages#contact_us'

  get 'my_tr', to: 'dashboards#index', as: "my_tr"

  resources :training_sessions
  resources :session_sets
  resources :session_strategies

  resources :brands
  resources :machines

  resources :exercises

end
