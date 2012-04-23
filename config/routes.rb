SemesterProject::Application.routes.draw do

  resources :authentications

  resources :users #adds all of the RESTful routes for users
  resources :sessions, :only => [:new, :create, :destroy] #routes for signing in and out

  root :to => 'pages#home'
  
  match '/signup', :to => 'users#new'
  match '/signin', :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
  match '/about', :to => 'pages#about'
  match '/contact', :to => 'pages#contact'
  match '/auth/:provider/callback' => 'authentications#create'

  #create pretty urls with /username instead of /users/user_id
  match "/:id", :to => "users#show", :as => :friendly_user 

end
