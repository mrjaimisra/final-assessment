Rails.application.routes.draw do
  root 'welcome#index'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'

  namespace :users, path: ":user", as: :user do
    resources :lists
    resources :links do
      member do
        patch "read"
        patch "unread"
      end
    end
  end
end

