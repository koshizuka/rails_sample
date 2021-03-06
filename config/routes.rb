SampleApp::Application.routes.draw do
  resources :projects do
    resources :tasks do
      member do
        post :change_status
      end
    end
    resources :tasks do
      post :sort
    end
  end
  resources :users do
    member do
      get :following, :followers
      post :upload_image
    end
  end

  resources :sessions,      only: [:new, :create, :destroy]
  resources :tasks,    only: [:create, :destroy, :sort]
  resources :relationships, only: [:create, :destroy]
  root to: 'static_pages#home'
  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
end
