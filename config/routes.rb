Rails.application.routes.draw do
  
  root 'landing#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :posts
  resources :users
  resources :comments
  resources :likes
  get "/register", to: "users#register"
  get "/login", to: "users#login"
  post "/login", to: "users#authenticate"
  get "logout", to: "users#logout"
end
