Rails.application.routes.draw do
  root 'welcome#index'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  namespace :users, path: ":user", as: :user do
    resources :links do
      member do
        patch "read"
        patch "unread"
      end
    end
  end
end

