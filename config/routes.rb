SemesterProject::Application.routes.draw do

  get "users/new"

  root :to => 'pages#home'
  
  match '/about', :to => 'pages#about'
  match '/contact', :to => 'pages#contact'

end
