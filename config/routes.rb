Rails.application.routes.draw do
  devise_for :users
  resources :groups do
    resources :reviews
  
  end
  root 'groups#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
