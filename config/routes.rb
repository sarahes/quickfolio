SemesterProject::Application.routes.draw do
  resources :users #adds all of the RESTful routes for users

  match '/signup', :to => 'users#new'

  root :to => 'pages#home'
  
  match '/about', :to => 'pages#about'
  match '/contact', :to => 'pages#contact'

end
