Rails.application.routes.draw do
  resources :users, only: [:new, :create, :edit, :update, :show]
  resources :tasks
  root to: 'tasks#index'
end
