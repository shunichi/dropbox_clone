Rails.application.routes.draw do
  root to: 'welcome#index'
  devise_for :users

  resources :inodes, only: [:index, :show, :create, :edit, :update, :destroy] do
    resources :inodes, only: [:new]
    resources :shares, only: [:create, :destroy]
    resources :share_links, only: [:create, :destroy]

    member do
      get :search
      get :shares
      get :activities
    end
  end

  resources :shares, only: [] do
    resources :inodes, only: [:show], controller: 'shares/inodes'
  end

  get '/uploads/:id/:basename.:extension', to: 'static_access#download'
end
