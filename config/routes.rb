Rails.application.routes.draw do
  # resources :user_sessions, only: [:create]
  resources :users, except: %i[new destroy]
  get "/signup", to: "users#new" #register
  get 'login', to: 'user_sessions#new', :as => :login
  post 'login', to: "user_sessions#create"
  post 'logout', to: 'user_sessions#destroy', :as => :logout
  get 'logout', to: 'user_sessions#destroy'
  root "home#home" #static_pages#home
  post "/" => "home#check_answer"
  post "decks/select_current_deck", to: "decks#select_current_deck"
  resources :cards
  resources :decks

  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback" # for use with Github, Facebook
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
  

end
