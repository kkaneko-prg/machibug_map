Rails.application.routes.draw do
  root 'static_pages#top'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :posts
  resources :users, only: %i[new create destroy]
  resource  :profile, only: %i[show edit update]
end
