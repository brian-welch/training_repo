Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'

  get 'my_tr', to: 'dashboards#index', as: "my_tr"

  resources :session_exercises
  resources :sessions

end
