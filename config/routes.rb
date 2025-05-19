Rails.application.routes.draw do
  get 'attendance_corrections/new'
  get 'attendance_corrections/create'
  get 'attendance_corrections/index'
  mount RailsAdmin::Engine => '/rails_admin', as: 'rails_admin'
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  get "up" => "rails/health#show", as: :rails_health_check

  resources :attendances, only: [:index, :create, :new]
  resources :leave_applications, only: [:new, :create, :index]
  resources :expense_applications, only: [:new, :create, :index]
  resources :attendance_corrections, only: [:new, :create, :index]

  namespace :admin do
    resources :attendance_corrections, only: [:index, :update]
    resources :leave_applications, only: [:index, :update]
    resources :expense_applications, only: [:index, :update]
  end

  root to: 'home#index'
end
