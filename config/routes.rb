Rails.application.routes.draw do
  
  get 'signouts/index'
  #namespace :dashboard do
    #resources :mains
    #root to: "mains#index" # The file we just created.
  #end
  resources :comments, :only => [:destroy, :show, :edit, :update]
  resources :posts do
    resources :comments, :only => [:create, :index, :new] 
  end

  devise_for :users, except: :create, path: '', path_name: { sign_in: 'login', sign_out: 'signed-out' }
  #get 'home/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "posts#index"
  get 'signed-out', to: 'signouts#index'
  post '/posts/:id/update', to: 'posts#update'

end
