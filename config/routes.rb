Rails.application.routes.draw do
  resources :posts
  resources :users
  root "posts#index" # or another controller and action that you want as the root
end


