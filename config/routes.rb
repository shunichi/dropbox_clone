Rails.application.routes.draw do
  root to: 'welcome#index'
  devise_for :users

  resources :inodes

  resources :inodes do
    get :new_file
    get :new_directory
    get :download
    get :search
  end
end
