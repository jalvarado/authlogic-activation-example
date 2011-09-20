AuthlogicActivationExample::Application.routes.draw do
  match '/register/:activation_code' => "activations#new", :as => 'registration'
  match '/activate/:id' => "activations#create", :as => 'activation'
  
  match "login" => "user_sessions#new", :as => "login"

  post "user_sessions/create"

  match "logout" => "user_sessions#destroy", :as => "logout"
  
  resources :users
  
  root :to => "users#index"
end
