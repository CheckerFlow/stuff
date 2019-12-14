Rails.application.routes.draw do
    
  
  get 'pages/home'
  get 'pages/landing'

  devise_for :users

  resources :rooms do
    resources :storages, shallow: true
  end

  resources :storages do
    resources :items, shallow: true
  end

  resources :items

  resources :lists do 
    member do
      get 'selectitems'
      post 'addItem'
      delete 'removeItem'
    end    
  end

  resources :early_access_requests

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root :to => "pages#landing"
end
