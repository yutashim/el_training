Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  namespace :admin do
    resources :users, only: [:index, :edit, :show]
  end
  resources :users, only: [:new, :create, :edit, :update, :show, :destroy]
  resources :tasks
  root to: 'tasks#index'
end
