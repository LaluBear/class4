Rails.application.routes.draw do
  resources :users
  delete '/users/:id', to: 'users#destroy'
  get 'create_fast', to: 'users#createnew' 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
