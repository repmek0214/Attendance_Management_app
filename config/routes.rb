Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  get "up" => "rails/health#show", as: :rails_health_check

  resources :attendances, only: [:index, :create]


  root to: 'home#index'
end
