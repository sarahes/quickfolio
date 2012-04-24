class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update] #only logged in users can edit 
  before_filter :authenticate_correct_user, :only => [:edit, :update] #also need to ensure users can only edit their own portfolio


  def new
  	@user = User.new
  	@title = "Sign Up"  	
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
      #if the user was saved to the database, sign them in, set the flash message and redirect to their show page
      sign_in @user
      flash[:success] = "You have successfully signed up for Quickfolio!"
      
      #once the user is initally created, forward them to the edit page so they can fill out their portfolio
  		render 'edit'
  	else
  		@title = "Sign Up"
  		render 'new'
  	end
  end

  def show
  	@user = User.find_by_user_name(params[:id]) || User.find_by_id(params[:id])
  	@title = @user.user_name

    #get the user's 5 most recent tweets
    @tweets = Twitter.user_timeline(@user.twitter_username, :count => 5)
    
    #get the user's github repositories
    github_user = GitHub::API.user(@user.github_username)

    @repos = github_user.repositories
  end

  def edit
    #@user = User.find(params[:id])
    @title = "Edit Portfolio"
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Portfolio successfully updated!"
      redirect_to @user
    else
      @title = "Edit Portfolio"
      render 'edit'
    end
  end

  private

    def authenticate
      deny_access unless signed_in?
    end

    def authenticate_correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

end
