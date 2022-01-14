Rails.application.routes.draw do
  root 'spots#index'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  get 'photos', to: 'posts#index'

  resources :posts, only: %i[new create edit update destroy show] do
    resources :comments, only: %i[create], shallow: true
  end
  resources :spots, only: %i[index]
  resources :users, only: %i[new create destroy]
  resource  :profile, only: %i[show edit update]
end
