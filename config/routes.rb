SemesterProject::Application.routes.draw do

  resources :users #adds all of the RESTful routes for users
  resources :sessions, :only => [:new, :create, :destroy] #routes for signing in and out

  root :to => 'pages#home'
  
  match '/signup', :to => 'users#new'
  match '/signin', :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
  match '/about', :to => 'pages#about'
  match '/contact', :to => 'pages#contact'

  match "/:id", :to => "users#show", :as => :friendly_user 

end
