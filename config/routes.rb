Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :edit, :update, :show]
  resources :tasks
  root to: 'tasks#index'
end
