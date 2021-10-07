Rails.application.routes.draw do
  resources :users
  resources :posts
  
  
  get '/user', to: 'users#newindex'
  get '/user/:id', to: 'users#show2'
  get 'create_fast', to: 'users#createnew'
  get '/posts/:id/edit', to: 'posts#edit' 
  get '/users/:id/createpost', to:'posts#new'
  
  post '/editpost', to: 'users#editpost'
  
  delete '/posts/:id', to: 'posts#destroy'
  delete '/users/:id', to: 'users#destroy' 
  get '/main', to: 'users#login'
  post '/users/login', to: 'users#attempt_login'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
