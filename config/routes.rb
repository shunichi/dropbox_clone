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
    post :share_link, to: 'inodes#create_share_link'
    delete :share_link, to: 'inodes#delete_share_link'
  end

  resources :shares, only: [:show] do
    resources :inodes, only: [:index, :show], controller: 'shares/inodes'
  end

  get '/uploads/:id/:basename.:extension', to: 'static_access#download'
end
