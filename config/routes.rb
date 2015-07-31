Rails.application.routes.draw do
  root to: 'welcome#index'
  devise_for :users

  resources :inodes do
    get :new_file
    get :new_directory
    get :download
    get :activities
    get :search
    get :share, to: 'inodes#edit_share'
    post :share, to: 'inodes#create_share'
    delete :share, to: 'inodes#delete_share'
  end
end
