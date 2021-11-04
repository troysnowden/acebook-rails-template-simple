Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :posts
  resources :users
  get "/register", to: "users#register"
  get "/login", to: "users#login"
  post "/login", to: "users#authenticate"
end
