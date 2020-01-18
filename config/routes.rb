Rails.application.routes.draw do
    
  get 'search/search'
  get 'pages/home'
  get 'pages/help'
  get 'pages/landing'
  get 'pages/about'

  resources :family_members

  resources :sharing_group_members

  devise_for :users

  concern :sharing_group_members do
    get 'sharing_group_members'
    post 'add_sharing_group_member'
    delete 'remove_sharing_group_member'
  end

  resources :buildings, concerns: :sharing_group_members  do 
    resources :rooms, shallow: true

    member do 
      get 'edit_images'
      get :download_image_attachments
      delete 'delete_image_attachment'
    end    
  end


  resources :rooms, concerns: :sharing_group_members  do
    resources :storages, shallow: true

    member do 
      get 'edit_images'
      get :download_image_attachments
      delete 'delete_image_attachment'
    end
  end

  resources :storages, concerns: :sharing_group_members  do
    resources :items, shallow: true

    resources :images

    member do 
      get 'edit_images'
      get :download_image_attachments
      delete 'delete_image_attachment'
      delete 'delete_items'
    end
  end

  resources :items, concerns: :sharing_group_members  do 
    member do 
      get 'edit_images'
      get :download_image_attachments
      delete 'delete_image_attachment'
    end    
  end    

  resources :lists, concerns: :sharing_group_members do 
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
