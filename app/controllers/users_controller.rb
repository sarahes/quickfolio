class UsersController < ApplicationController

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
  		redirect_to @user
  	else
  		@title = "Sign Up"
  		render 'new'
  	end
  end

  def show
  	@user = User.find(params[:id])
  	@title = @user.user_name
  end

end
