Rails3BootstrapDeviseCancan::Application.routes.draw do
  authenticated :user do
    root :to => 'shots#following'
  end
  get 'tags/:tag', to: 'shots#index', as: :tag
  root :to => "home#index"

  devise_for :users
  resources :users do
    member do
      get :following, :followers
    end
    resources :shots
  end

  devise_for :shots
  match 'shots/following', to: 'shots#following'
  resources :shots do
    resources :comments
    resources :rebounds
    match 'shots/likes/:id', to: 'shots#likes'
  end

  devise_for :rebounds

  resources :relationships, only: [:create, :destroy]
  resources :search
  match ':controller(/:action(/:id))(.:format)'
  match 'site/about', to: 'site#about'
end