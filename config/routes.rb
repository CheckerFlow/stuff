Rails.application.routes.draw do
    
  devise_for :users
  resources :rooms do
    resources :storages, shallow: true
  end

  resources :storages do
    resources :items, shallow: true
  end
  resources :items

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root :to => "rooms#index"

  get '/rooms_cleanup', to: 'rooms#cleanup'
end
