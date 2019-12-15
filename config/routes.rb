Rails.application.routes.draw do
    
  get 'search/search'
  get 'pages/home'
  get 'pages/landing'
  get 'pages/about'

  devise_for :users

  resources :rooms do
    resources :storages, shallow: true
    member do 
      get 'edit_images'
      delete 'delete_image_attachment'
    end
  end

  resources :storages do
    resources :items, shallow: true

    member do 
      get 'edit_images'
      delete 'delete_image_attachment'
    end
  end

  resources :items do 
    member do 
      get 'edit_images'
      delete 'delete_image_attachment'
    end    
  end    

  resources :lists do 
    member do
      get 'selectitems'
      post 'addItem'
      delete 'removeItem'
    end    
  end

  resources :list_items, only: [:create, :destroy, :index]

  resources :early_access_requests

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root :to => "pages#landing"
end
