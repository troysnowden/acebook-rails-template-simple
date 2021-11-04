Rails.application.routes.draw do
<<<<<<< HEAD
  
  root 'home#index'
  get 'home/test-bar'
=======
  root 'landing#index'
>>>>>>> main
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :posts
end
