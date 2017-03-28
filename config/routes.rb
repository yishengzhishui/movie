Rails.application.routes.draw do



  devise_for :users
  resources :groups do
    member do
      post :join
      post :quit
    end
    resources :reviews

  end

  namespace :account do
    resources :groups
    resources :reviews
  end

  resources :welcome do
  end

  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
