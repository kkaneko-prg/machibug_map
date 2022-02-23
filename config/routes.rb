Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  root 'spots#index'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  get 'photos', to: 'posts#index'

  get 'about', to: 'static_pages#about'
  get 'terms', to: 'static_pages#terms'
  get 'privacy', to: 'static_pages#privacy'

  resources :posts, only: %i[new create edit update destroy show] do
    resources :comments, only: %i[create destroy], shallow: true
  end

  resources :likes, only: %i[create destroy]
  resources :spots, only: %i[index]
  resources :users, only: %i[new create destroy]
  resource  :profile, only: %i[show edit update]
  resources :password_resets, only: %i[new create edit update]
  resources :contacts, only: %i[new create]
end
